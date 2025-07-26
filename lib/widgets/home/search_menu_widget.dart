import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/value_provider.dart';
import '../inputs/text_input_widget.dart';

class SearchMenuWidget extends ConsumerWidget {
  const SearchMenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(searchProductProvider);
    return Row(
      children: [
        Expanded(
          child: TextInputWidget(
            initialValue: search,
            hintText: 'Search Product...',
            onFieldSubmitted: (x) {
              ref.read(searchProductProvider.notifier).state = x;
            },
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.filter_list_rounded),
        ),
      ],
    );
  }
}
