import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart';
import '../inputs/password_input_widget.dart';

class UpdatePasswordWidget extends HookConsumerWidget {
  const UpdatePasswordWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    var currentPassword = useTextEditingController();
    var newPassword = useTextEditingController();
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        children: [
          PasswordInputWidget(
            controller: currentPassword,
            hintText: 'Current Password*',
          ),
          const SizedBox(height: 12),
          PasswordInputWidget(
            controller: newPassword,
            hintText: 'New Password*',
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // ref.read(authProvider.notifier).updatePassword(
              //       currentPassword: currentPassword.text.trim(),
              //       newPassword: newPassword.text.trim(),
              //     );
            },
            style: TextButton.styleFrom(
              backgroundColor: ColorConstants.primary,
            ),
            child: Text(
              'Update Password',
              style: typoConfig.textStyle.buttonsButtonSmall
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
