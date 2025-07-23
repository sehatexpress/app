import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/lottie_files.dart';
import '../../widgets/basket/bill_summary_widget.dart';
import '../../providers/basket_provider.dart' show basketProvider;
import '../../widgets/basket/apply_voucher_widget.dart';
import '../../widgets/basket/basket_appbar_widget.dart';
import '../../widgets/basket/basket_items_widget.dart';
import '../../widgets/basket/cancellation_policy_widget.dart';
import '../../widgets/basket/default_confirmation_order_widget.dart';
import '../../widgets/basket/monimum_order_notice_widget.dart';
import '../../widgets/basket/place_order_button_widget.dart';
import '../../widgets/basket/tip_widget.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(basketProvider.select((state) => state.items));
    return Scaffold(
      appBar: AppBar(title: const BasketAppbarWidget()),
      body: items.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              children: const [
                MinimumOrderNoticeWidget(),
                BasketItemsWidget(),
                ApplyVoucherWidget(),
                TipWidget(),
                DefaultConfirmOrderWidget(),
                BillSummaryWidget(),
                CancellationPolicyWidget(),
              ],
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieFiles.emptyCart,
                  const Text(
                    'Your basket is empty.\nAdd items to place order.',
                    maxLines: 3,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: items.isNotEmpty
          ? const BottomAppBar(
              height: 110,
              padding: EdgeInsets.zero,
              color: Colors.transparent,
              surfaceTintColor: Colors.white,
              child: PlaceOrderButtonWidget(),
            )
          : null,
    );
  }
}
