import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/string_constants.dart';
import '../../config/typo_config.dart';
import '../../providers/global_provider.dart';
import '../../providers/lists_provider.dart';
import '../../services/user_service.dart' show userServiceProvider;
import '../inputs/email_input.dart';
import '../inputs/phone_input.dart';
import '../inputs/name_input.dart';
import '../inputs/select_gender_widget.dart';

class UpdateProfileWidget extends HookConsumerWidget {
  const UpdateProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(userDetailProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    var name = useTextEditingController();
    var email = useTextEditingController();
    var phone = useTextEditingController();
    var gender = useState<int>(1);

    useEffect(() {
      if (detail.hasValue) {
        final value = detail.value;
        if (value != null) {
          gender.value = value.gender ?? 1;
          name.text = value.name;
          email.text = value.email ?? '';
          phone.text = value.phone;
        }
      }
      return null;
    }, [detail]);
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        children: [
          SelectGenderWidget(
            gender: gender.value,
            onTap: (e) => gender.value = e,
          ),
          const SizedBox(height: 12),
          NameInput(controller: name),
          const SizedBox(height: 12),
          EmailInput(enabled: false, controller: email),
          const SizedBox(height: 12),
          PhoneInput(
            controller: phone,
            onChanged: (val) async {
              try {
                if (val.isNotEmpty && val.length == 10) {
                  if (val.trim() != detail.value?.phone) {
                    var isUserExistWithphone = await ref
                        .read(userServiceProvider)
                        .checkRegisteredUser(val);
                    if (isUserExistWithphone) {
                      ref.read(messageProvider.notifier).state =
                          Strings.duplicatePhone;
                      phone.text = detail.value?.phone ?? '';
                    }
                  }
                }
              } catch (_) {}
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // ref.read(authProvider.notifier).updateProfile(
              //       name: name.text.trim(),
              //       gender: gender.value,
              //       phone: phone.text.trim(),
              //     );
            },
            style: TextButton.styleFrom(
              backgroundColor: ColorConstants.primary,
            ),
            child: Text(
              'Update Profile',
              style: typoConfig.textStyle.buttonsButtonSmall.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
