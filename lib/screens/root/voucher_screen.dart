import 'package:flutter/material.dart';

import '../../widgets/voucher/voucher_list_by_all_widget.dart';
import '../../widgets/voucher/voucher_list_by_city_widget.dart';
import '../../widgets/voucher/voucher_list_by_restaurant_widget.dart';
import '../../widgets/voucher/voucher_list_by_user_widget.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Voucher'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          VoucherListByUserWidget(),
          VoucherListByRestaurantsWidget(),
          VoucherListByCityWidget(),
          VoucherListByAllWidget(),
        ],
      ),
    );
  }
}
