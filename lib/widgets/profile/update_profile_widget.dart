import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/string_constants.dart';
import '../../config/typo_config.dart';
import '../../providers/auth_provider.dart';
import '../../providers/global_provider.dart';
import '../../services/user_service.dart' show userServiceProvider;
import '../inputs/email_input.dart';
import '../inputs/name_input.dart';
import '../inputs/phone_input.dart';

class UpdateProfileWidget extends HookConsumerWidget {
  const UpdateProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(authProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    var name = useTextEditingController(text: detail?.displayName ?? '');
    var email = useTextEditingController(text: detail?.email ?? '');
    var phone = useTextEditingController(
      text: detail?.phoneNumber?.split('+91').last ?? '',
    );

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          spacing: 12,
          children: [
            NameInput(controller: name),
            EmailInput(enabled: false, controller: email),
            PhoneInput(
              controller: phone,
              onChanged: (val) async {
                try {
                  if (val.isNotEmpty && val.length == 10) {
                    if (val.trim() != detail?.phoneNumber?.split('+91').last) {
                      var isUserExistWithphone = await ref
                          .read(userServiceProvider)
                          .checkRegisteredUser(val);
                      if (isUserExistWithphone) {
                        ref.read(messageProvider.notifier).state =
                            Strings.duplicatePhone;
                        phone.text =
                            detail?.phoneNumber?.split('+91').last ?? '';
                      }
                    }
                  }
                } catch (_) {}
              },
            ),
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
      ),
    );
  }
}
