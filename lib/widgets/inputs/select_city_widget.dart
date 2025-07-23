import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;

import '../../config/utils.dart' show textDecorationTextStyle;
import '../../providers/lists_provider.dart' show citySettingsListProvider;
import '../../providers/location_provider.dart' show locationProvider;
import '../generic/loader_widget.dart';

class SelectCityWidget extends ConsumerWidget {
  const SelectCityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(locationProvider).city;
    final cities = ref.watch(citySettingsListProvider);
    return SizedBox(
      height: 36,
      child: cities.when(
        data: (data) {
          return DropdownButtonFormField<String>(
            value: city,
            isExpanded: true,
            hint: const Text('Select city...'),
            items: data
                .map((val) => DropdownMenuItem<String>(
                      value: val.id.toLowerCase(),
                      child: Text(val.id),
                    ))
                .toList(),
            onChanged: (x) => ref.read(locationProvider.notifier).updateCity(x),
            style: textDecorationTextStyle(const Color.fromARGB(197, 0, 0, 0)),
            decoration: const InputDecoration(
              isDense: true,
              border: _border,
              enabledBorder: _border,
              focusedBorder: _border,
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text('Something went wrong...'),
        ),
        loading: () => Center(
          child: LoaderWidget(),
        ),
      ),
    );
  }
}

const _border = OutlineInputBorder(
  borderSide: BorderSide(
    width: .5,
    color: Color.fromARGB(90, 158, 158, 158),
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(8),
  ),
);
