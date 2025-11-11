import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/constants.dart';
import '../config/extensions.dart';
import '../widgets/auth/phone_auth.dart';
import '../widgets/auth/register_card.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authType = useState<int>(0); // 0: Login, 1: Register
    final phone = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (authType.value == 0)
                PhoneAuth(phone: phone, onRegister: () => authType.value = 1),
              if (authType.value == 1)
                RegisterCardWidget(phone: phone.text.trim()),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'OR',
                  style: context.text.labelMedium?.copyWith(
                    height: 1,
                    color: ColorConstants.textColor,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  authType.value = 0;
                },
                child: Text('Login with phone OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
