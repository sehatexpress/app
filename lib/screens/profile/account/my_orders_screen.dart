import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/lists_provider.dart' show ordersListProvider;
import '../../../widgets/basket/order_card_widget.dart';
import '../../../widgets/generic/loader_widget.dart';

class MyOrdersScreen extends ConsumerWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(ordersListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: lists.when(
        data: (orders) {
          if (orders.isEmpty) {
            return Center(
              child: Text('No order!'),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(16).copyWith(top: 8),
            itemBuilder: (_, i) => OrderCardWidget(
              order: orders[i],
            ),
            separatorBuilder: (_, i) => const SizedBox(height: 12),
            itemCount: orders.length,
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => Center(
          child: LoaderWidget(),
        ),
      ),
    );
  }
}
