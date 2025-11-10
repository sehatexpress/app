import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/basket_provider.dart' show basketProvider;

class DefaultConfirmOrderWidget extends ConsumerWidget {
  const DefaultConfirmOrderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var value =
        ref.watch(basketProvider.select((state) => state.defaultConfirmed));
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: CheckboxListTile(
        dense: true,
        value: value,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        controlAffinity: ListTileControlAffinity.leading,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        onChanged: (x) =>
            ref.read(basketProvider.notifier).updateDefaultConfirmed(x),
        title: Text('Confirm the order without calling.(Don\'t call)?'),
      ),
    );
  }
}
