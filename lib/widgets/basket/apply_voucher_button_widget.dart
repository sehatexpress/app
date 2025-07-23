import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import '../../config/extensions.dart';

import '../../providers/global_provider.dart' show globalProvider;
import '../../config/constants.dart' show ColorConstants;
import '../../config/string_constants.dart' show Strings;
import '../../providers/auth_provider.dart' show authUidProvider;
import '../../providers/basket_provider.dart' show basketProvider;
import '../../screens/root/voucher_screen.dart';

class ApplyVoucherButton extends ConsumerWidget {
  const ApplyVoucherButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var uid = ref.read(authUidProvider);
    var voucher = ref.watch(basketProvider.select((state) => state.voucher));
    return GestureDetector(
      onTap: () async {
        if (uid != null) {
          if (voucher != null) {
            ref.read(basketProvider.notifier).applyVoucher(null);
          } else {
            context.push(const VoucherScreen());
          }
        } else {
          ref
              .read(globalProvider.notifier)
              .updateMessage(Strings.loginToApplyVoucher);
        }
      },
      child: Text(
        voucher != null ? 'Remove' : 'Apply Now',
        style: TextStyle(
          color: ColorConstants.primary,
        ),
      ),
    );
  }
}
