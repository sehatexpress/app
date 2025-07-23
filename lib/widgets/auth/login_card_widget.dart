// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'
    show useMemoized, useTextEditingController;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show HookConsumerWidget, WidgetRef;

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart';
import '../../providers/auth_provider.dart' show authProvider;
import '../dialogs/forgot_password_dialog.dart';
import '../inputs/email_input_widget.dart';
import '../inputs/password_input_widget.dart';

class LoginCardWidget extends HookConsumerWidget {
  const LoginCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var formKey = useMemoized(() => GlobalKey<FormState>());
    var email = useTextEditingController();
    var password = useTextEditingController();
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          EmailInputWidget(controller: email),
          const SizedBox(height: 12),
          PasswordInputWidget(controller: password),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ForgetPasswordDialog(),
                );
              },
              child: Text(
                'Forgot Password?',
                style: typoConfig.textStyle.smallCaptionSubtitle2.copyWith(
                  height: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              label: Text(
                'Login',
                style: typoConfig.textStyle.largeCaptionLabel3Bold
                    .copyWith(color: Colors.white),
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
                    await ref.read(authProvider.notifier).login(
                          email: email.text.trim().toLowerCase(),
                          password: password.text.trim(),
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
