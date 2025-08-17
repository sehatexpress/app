import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/value_provider.dart';

class SearchInputWidget extends HookConsumerWidget {
  final String hintText;
  const SearchInputWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      onChanged: (val) => ref.read(searchProductProvider.notifier).state = val,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      onFieldSubmitted: (val) {
        ref.read(searchProductProvider.notifier).state = val;
        FocusScope.of(context).unfocus();
      },
    );
  }
}
