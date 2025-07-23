import 'package:flutter/material.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/enums.dart' show FilterEnum;
import '../../config/extensions.dart' show FilterEnumValue;
import '../../config/typo_config.dart' show typoConfig;

class MenuFilterWidget extends StatelessWidget {
  final FilterEnum? filter;
  final Function(FilterEnum?)? onUpdate;
  const MenuFilterWidget({
    super.key,
    this.filter,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    List<FilterEnum> lists =
        FilterEnum.values.where((e) => e != FilterEnum.both).toList();
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 8,
            ),
            child: Text(
              'Filter',
              style: typoConfig.textStyle.smallBodyBodyText1,
            ),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(left: 8),
              itemBuilder: (context, index) {
                bool selected = filter == lists[index];
                return GestureDetector(
                  onTap: () => onUpdate?.call(lists[index]),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: .5,
                        color: selected ? Colors.transparent : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      color: selected
                          ? ColorConstants.primary
                          : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      lists[index].value,
                      style: typoConfig.textStyle.smallSmall.copyWith(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight:
                            selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
              itemCount: lists.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
            ),
          ),
        ],
      ),
    );
  }
}
