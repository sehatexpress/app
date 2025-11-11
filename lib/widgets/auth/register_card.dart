import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../providers/auth_provider.dart';
import '../../providers/global_provider.dart';
import '../../services/http_service.dart';
import '../generic/submit_button.dart';
import '../inputs/email_input.dart';
import '../inputs/name_input.dart';
import '../inputs/password_input.dart';
import '../inputs/phone_input.dart';

class RegisterCardWidget extends HookConsumerWidget {
  final String phone;
  const RegisterCardWidget({super.key, required this.phone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final phoneCtrl = useTextEditingController(text: phone);
    final name = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    return Form(
      key: formKey,
      child: Column(
        spacing: 12,
        children: [
          PhoneInput(controller: phoneCtrl, enabled: false),
          NameInput(controller: name),
          EmailInput(controller: email),
          PasswordInput(controller: password),
          SubmitButton(
            title: 'Register',
            icon: Icons.person,
            onPressed: () async {
              ref.withLoading(() async {
                if (formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  ref.read(loadingProvider.notifier).state = true;
                  var res = await ref
                      .read(httpServiceProvider)
                      .createUser(
                        name: name.text.trim().toLowerCase(),
                        phone: phoneCtrl.text.trim(),
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );
                  if (res.isNotEmpty &&
                      res.containsKey('success') &&
                      res['success'] == true &&
                      res.containsKey('token') &&
                      res['token'] != null) {
                    final token = res['token'];
                    if (token != null) {
                      await ref
                          .read(authProvider.notifier)
                          .loginWithToken(res['token']);
                    }
                    context.showSnackbar('Registered successfully!');
                  }
                  throw res['message'];
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
