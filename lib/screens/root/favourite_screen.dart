import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/auth_provider.dart' show authUidProvider;
import '../../widgets/auth/auth_button_widget.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var uid = ref.watch(authUidProvider);
    if (uid == null) {
      return const Center(child: AuthButtonWidget());
    }
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16).copyWith(bottom: 66),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => Center(child: Text('ITEM')),
      separatorBuilder: (_, i) => const SizedBox(height: 16),
      itemCount: 10,
    );
  }
}
