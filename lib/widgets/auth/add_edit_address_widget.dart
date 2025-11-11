import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart';
import '../../models/address_model.dart';
import '../../models/location_model.dart';
import '../../providers/address_provider.dart' show addressProvider;
import '../../providers/auth_provider.dart';
import '../../providers/location_provider.dart';
import '../dialogs/addrss_picker_dialog.dart';
import '../inputs/address_type_input.dart';
import '../inputs/name_input.dart';
import '../inputs/phone_input.dart';
import '../inputs/text_input_widget.dart';

class AddEditAddressWidget extends HookConsumerWidget {
  final AddressModel? address;
  const AddEditAddressWidget({super.key, this.address});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var auth = ref.read(authProvider);
    var location = ref.read(locationProvider);
    var formKey = useMemoized(() => GlobalKey<FormState>());
    var name = useTextEditingController(
      text: address?.name ?? auth?.displayName ?? '',
    );
    var phone = useTextEditingController(
      text: address?.phone ?? auth?.phoneNumber?.split('+91').last ?? '',
    );
    var type = useState<String?>(address?.addressType ?? 'home');
    var street = useTextEditingController(text: address?.street);
    var lat = useState<double>(
      address?.position.geopoint.latitude ?? location.latitude,
    );
    var lng = useState<double>(
      address?.position.geopoint.longitude ?? location.longitude,
    );

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            NameInput(controller: name),
            PhoneInput(controller: phone),
            AddressTypeInput(
              selected: type.value,
              onTap: (e) => type.value = e,
            ),
            Row(
              children: [
                Expanded(
                  child: TextInputWidget(
                    enabled: false,
                    controller: street,
                    hintText: 'Address',
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    LocationModel locationModel =
                        location.location ??
                        LocationModel(
                          latitude: 0,
                          longitude: 0,
                          displayName: 'Unknown',
                          city: 'Unknown',
                        );
                    LocationModel? selectedLocation =
                        await showDialog<LocationModel>(
                          context: context,
                          builder: (context) => AddressPickerDialog(
                            initialLocation: locationModel,
                          ),
                        );
                    if (selectedLocation != null) {
                      lat.value = selectedLocation.latitude;
                      lng.value = selectedLocation.longitude;
                      street.text = selectedLocation.displayName;
                    }
                  },
                  icon: const Icon(Icons.location_on),
                ),
              ],
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
                backgroundColor: ColorConstants.primary,
              ),
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    if (address != null) {
                      await ref
                          .read(addressProvider.notifier)
                          .updateAddress(
                            addressId: address!.id!,
                            name: name.text.trim(),
                            phone: phone.text.trim(),
                            type: type.value ?? 'home',
                            address: street.text.trim(),
                            latitude: lat.value,
                            longitude: lng.value,
                          );
                    } else {
                      await ref
                          .read(addressProvider.notifier)
                          .addAddress(
                            name: name.text.trim(),
                            phone: phone.text.trim(),
                            type: type.value ?? 'home',
                            address: street.text.trim(),
                            latitude: lat.value,
                            longitude: lng.value,
                          );
                    }
                    Navigator.pop(context);
                  }
                } catch (_) {}
              },
              child: Text(
                'Submit',
                style: typoConfig.textStyle.buttonsButtonSmall.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
