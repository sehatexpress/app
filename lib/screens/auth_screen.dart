import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/constants.dart';
import '../config/extensions.dart';
import '../providers/auth_provider.dart';
import '../providers/global_provider.dart';
import '../widgets/inputs/mobile_input_widget.dart';
import '../widgets/inputs/otp_input_widget.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);
    final loading = ref.watch(loadingProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final phoneController = useTextEditingController();
    final otpController = useTextEditingController();
    final timer = useState(60);
    final isOTPSent = ref.watch(isOTPSentProvider);

    useEffect(() {
      if (isOTPSent && timer.value > 0) {
        final interval = Timer.periodic(Duration(seconds: 1), (t) {
          if (timer.value <= 1) {
            t.cancel();
          } else {
            timer.value--;
          }
        });
        return interval.cancel;
      }
      return null;
    }, [isOTPSent]);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MobileInputWidget(controller: phoneController),
              const SizedBox(height: 12),
              if (isOTPSent) ...[
                OTPInputWidget(
                  onSubmit: (code) {
                    try {
                      if (code.length == 6) {
                        auth.verifyOTP(otpController.text.trim());
                      } else {
                        context.showSnackbar(
                          'Please enter 6 digit OTP sent to your number!',
                        );
                      }
                    } catch (e) {
                      context.showSnackbar(
                        'Something went wrong: ${e.toString()}',
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          try {
                            if (isOTPSent) {
                              if (otpController.text.isNotEmpty &&
                                  otpController.text.trim().length == 6) {
                                auth.verifyOTP(otpController.text.trim());
                              } else {
                                context.showSnackbar(
                                  'Please enter 6 digit OTP sent to your mobile number!',
                                );
                              }
                            } else {
                              if (phoneController.text.isNotEmpty &&
                                  phoneController.text.trim().length == 10) {
                                auth.sendOTP(
                                  phoneNumber: phoneController.text.trim(),
                                  onCodeSent: () {
                                    ref.read(isOTPSentProvider.notifier).state =
                                        true;
                                    timer.value = 60;
                                  },
                                );
                              } else {
                                context.showSnackbar(
                                  'Please enter your 10 digit mobile number!',
                                );
                              }
                            }
                          } catch (e) {
                            context.showSnackbar(
                              'Something went wrong: ${e.toString()}',
                            );
                          }
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: ColorConstants.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isOTPSent ? "Verify OTP" : "Send OTP",
                    style: context.text.labelMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (timer.value > 0)
                Text("Resend OTP in ${timer.value} seconds")
              else
                TextButton(onPressed: () {}, child: const Text("Resend OTP")),
            ],
          ),
        ),
      ),
    );
  }
}
