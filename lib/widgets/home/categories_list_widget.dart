import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/lists_provider.dart' show categoriesListProvider;
import '../generic/loader_widget.dart';
import 'category_card_widget.dart';

class CategoriesListWidget extends ConsumerWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(categoriesListProvider).when(
          data: (data) {
            return data.isNotEmpty
                ? Container(
                    height: 88 * 4,
                    color: Colors.transparent,
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, i) =>
                          CategoryCard(category: data[i]),
                    ),
                  )
                : const SizedBox();
          },
          error: (err, stack) => const SizedBox(),
          loading: () => Center(
            child: LoaderWidget(),
          ),
        );
  }
}
