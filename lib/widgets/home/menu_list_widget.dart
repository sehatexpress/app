import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../providers/value_provider.dart';
import '../generic/loader_widget.dart';

class MenuListWidget extends ConsumerWidget {
  const MenuListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(randomNumberProvider);
    return asyncValue.when(
      data: (data) => ListView.separated(
        shrinkWrap: true,
        itemCount: data,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (_, i) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(25),
                offset: const Offset(2, 2),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(height: 200, color: ColorConstants.primary),
              Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Healthy Khichdi',
                            style: context.text.titleSmall,
                          ),
                        ),
                        Text(
                          '₹149',
                          style: context.text.titleSmall?.copyWith(
                            color: ColorConstants.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This is the description of the the menu item which will be shown to the user',
                      style: context.text.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (_, i) => const SizedBox(height: 12),
      ),
      error: (e, _) => Center(child: Text('ERROR: ${e.toString()}')),
      loading: () => const Center(child: LoaderWidget()),
    );
  }
}
