import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/value_provider.dart';

class SearchInputWidget extends HookConsumerWidget {
  final String hintText;
  const SearchInputWidget({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(valueProvider.notifier);
    useEffect(() {
      return () => Future.microtask(() => notifier.clear());
    }, []);
    return TextFormField(
      onChanged: (val) => notifier.setSearch(val),
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
      ),
      onFieldSubmitted: (val) {
        notifier.setSearch(val);
        FocusScope.of(context).unfocus();
      },
    );
  }
}
