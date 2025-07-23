import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/string_constants.dart' show Strings;
import '../../config/typo_config.dart';
import '../../providers/auth_provider.dart';
import '../../providers/global_provider.dart' show globalProvider;
import '../../providers/location_provider.dart';
import '../../services/user_service.dart' show userServiceProvider;
import '../inputs/address_type_input.dart';
import '../inputs/email_input_widget.dart';
import '../inputs/mobile_input_widget.dart';
import '../inputs/name_input_widget.dart';
import '../inputs/password_input_widget.dart';
import '../inputs/select_gender_widget.dart';

class RegisterCardWidget extends HookConsumerWidget {
  const RegisterCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var location = ref.watch(locationProvider);
    var formKey = useMemoized(() => GlobalKey<FormState>());
    var gender = useState<int>(1);
    var name = useTextEditingController();
    var email = useTextEditingController();
    var password = useTextEditingController();
    var mobile = useTextEditingController();
    var addressType = useState<String?>(null);
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          SelectGenderWidget(
            gender: gender.value,
            onTap: (e) => gender.value = e,
          ),
          const SizedBox(height: 12),
          NameInputWidget(controller: name),
          const SizedBox(height: 12),
          EmailInputWidget(controller: email),
          const SizedBox(height: 12),
          MobileInputWidget(
            controller: mobile,
            onChanged: (val) async {
              if (val.isNotEmpty && val.length == 10) {
                var isUserExistWithMobile = await ref
                    .read(userServiceProvider)
                    .checkRegisteredUser(val);
                if (isUserExistWithMobile) {
                  ref
                      .read(globalProvider.notifier)
                      .updateMessage(Strings.duplicateMobile);
                  mobile.clear();
                }
              }
            },
          ),
          const SizedBox(height: 12),
          PasswordInputWidget(controller: password),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (location.enabled)
                    const Text('Save address as')
                  else
                    const SizedBox(),
                  // const ForgetPasswordWidget(),
                ],
              ),
              if (location.enabled) ...[
                const SizedBox(height: 8),
                AddressTypeInput(
                  selected: addressType.value,
                  onTap: (e) => addressType.value = e,
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              label: Text(
                'Register',
                style: typoConfig.textStyle.largeCaptionLabel3Bold
                    .copyWith(color: Colors.white),
              ),
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              style: TextButton.styleFrom(
                backgroundColor: ColorConstants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    await ref.read(authProvider.notifier).register(
                          email: email.text.trim(),
                          password: password.text.trim(),
                          name: name.text.trim(),
                          mobile: mobile.text.trim(),
                          gender: gender.value,
                          type: addressType.value,
                        );
                    Navigator.pop(context);
                  }
                } catch (_) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
