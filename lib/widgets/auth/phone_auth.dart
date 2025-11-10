import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/extensions.dart';
import '../../providers/auth_provider.dart';
import '../../services/http_service.dart';
import '../generic/submit_button.dart';
import '../inputs/phone_input.dart';
import '../inputs/otp_input.dart';

class PhoneAuth extends HookConsumerWidget {
  final TextEditingController phone;
  final Function() onRegister;
  const PhoneAuth({super.key, required this.phone, required this.onRegister});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(httpServiceProvider);
    final otpSent = useState<bool>(false);
    final otp = useState<String?>(null);

    Future<void> requestOTP() async {
      ref.withLoading(() async {
        final txt = phone.text.trim();
        FocusScope.of(context).unfocus();
        if (txt.isNotEmpty && txt.length == 10) {
          Map<String, dynamic>? result = await notifier.requestOTP(txt);
          if (result.isNotEmpty &&
              result.containsKey('success') &&
              result['success'] == true) {
            context.showSnackbar(result['message']);
            otpSent.value = true;
          } else {
            throw result['message'];
          }
        } else {
          throw 'Please enter your 10 digit phone number!';
        }
      });
    }

    Future<void> verifyOTP() async {
      await ref.withLoading(() async {
        FocusScope.of(context).unfocus();
        if (otp.value != null && otp.value!.length == 4) {
          Map<String, dynamic>? result = await notifier.verifyOTP(
            phone: phone.text.trim(),
            otp: otp.value!,
          );
          if (result.isNotEmpty &&
              result.containsKey('success') &&
              result['success'] == true) {
            final token = result['token'];
            if (token != null) {
              await ref.read(authProvider.notifier).loginWithToken(token);
              context.pop();
            } else {
              context.showSnackbar(
                'You are not registered. Please sign up first.',
              );
              onRegister();
            }
          } else {
            throw result['message'];
          }
        } else {
          throw 'Please enter your 4 digit OTP sent to your phone!';
        }
      });
    }

    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: PhoneInput(controller: phone, enabled: !otpSent.value),
            ),
            if (otpSent.value)
              IconButton(
                onPressed: () => otpSent.value = false,
                icon: const Icon(Icons.edit),
              ),
          ],
        ),
        if (otpSent.value) OtpInputField(onCompleted: (x) => otp.value = x),
        SubmitButton(
          title: otpSent.value ? 'Verify OTP' : 'Request OTP',
          icon: Icons.phone,
          onPressed: otpSent.value ? verifyOTP : requestOTP,
        ),
      ],
    );
  }
}
