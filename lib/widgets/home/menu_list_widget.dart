import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart';
import '../../config/extensions.dart';
import '../../providers/value_provider.dart';
import '../generic/custom_image_provider.dart';
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
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomImageProvider(
                        image:
                            'https://media.istockphoto.com/id/1457979959/photo/snack-junk-fast-food-on-table-in-restaurant-soup-sauce-ornament-grill-hamburger-french-fries.jpg?s=612x612&w=0&k=20&c=QbFk2SfDb-7oK5Wo9dKmzFGNoi-h8HVEdOYWZbIjffo=',
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_outline,
                              size: 13,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '4.6',
                              style: context.text.labelSmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: ColorConstants.primary,
                            padding: EdgeInsets.zero,
                          ),
                          icon: const Icon(
                            Icons.favorite_outline,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: ColorConstants.secondary.withAlpha(28),
                        ),
                        color: ColorConstants.secondary.withAlpha(10),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.bolt_outlined,
                                color: ColorConstants.secondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Nutrition per serving',
                                style: context.text.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          GridView.count(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            padding: EdgeInsets.zero,
                            childAspectRatio:
                                ((context.screenWidth - 88) / 2) / 15,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                            children: List.generate(
                              _lists.length,
                              (i) => Text(
                                _lists[i],
                                style: context.text.labelSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          fixedSize: Size(double.infinity, 40),
                          backgroundColor: ColorConstants.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        label: Text(
                          'Add to Cart',
                          style: context.text.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        icon: Icon(Icons.add, color: Colors.white),
                      ),
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

List<String> _lists = [
  'Calories: 350',
  'Protein: 35g',
  'Carbs: 20g',
  'Fat: 8g',
];
