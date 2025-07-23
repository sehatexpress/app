import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (_, i) => Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      separatorBuilder: (_, i) => const SizedBox(height: 12),
    );
  }
}
