import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/constants.dart' show ColorConstants;
import '../../config/typo_config.dart' show typoConfig;
import '../../config/utils.dart'
    show outlineInputBorder, textDecorationTextStyle;
import '../../providers/basket_provider.dart' show basketProvider;
import 'bill_summary_title_widget.dart';

class TipWidget extends HookConsumerWidget {
  const TipWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tipController = useTextEditingController();
    var tip = ref.watch(basketProvider.select((state) => state.tip));
    var constraints = BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width * .19 - 2,
    );
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: BillSummaryTitleWidget(
        title: 'Tip your hunger saviour',
        desc: 'Note:- All tip will directly go to your delivery partner.',
        widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ...<double>[30, 40, 50, 60, 70, 80, 90].map(
                (e) => GestureDetector(
                  onTap: () {
                    tipController.clear();
                    final val = tip != e.toDouble() ? e.toDouble() : null;
                    ref.read(basketProvider.notifier).applyTip(val);
                  },
                  child: Container(
                    height: 30,
                    constraints: constraints,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: tip != e.toDouble()
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100),
                        width: .5,
                      ),
                    ),
                    child: Text(
                      'रु$e',
                      style: typoConfig.textStyle.smallSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: tip == e.toDouble()
                            ? Colors.white
                            : ColorConstants.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 30,
                constraints: constraints,
                child: TextField(
                  controller: tipController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                  ],
                  style: textDecorationTextStyle(ColorConstants.textColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    hintText: 'Tip Amount',
                    border: outlineInputBorder(
                        ColorConstants.primary.withAlpha(100)),
                    enabledBorder: outlineInputBorder(
                        ColorConstants.primary.withAlpha(100)),
                    focusedBorder: outlineInputBorder(
                        ColorConstants.primary.withAlpha(100)),
                  ),
                  onTapOutside: (p) {
                    FocusScope.of(context).unfocus();
                    if (tipController.text.isNotEmpty) {
                      final val = double.tryParse(tipController.text) ?? 0;
                      ref.read(basketProvider.notifier).applyTip(val);
                    }
                  },
                  onSubmitted: (x) {
                    if (x.isNotEmpty) {
                      final val = double.tryParse(x) ?? 0;
                      ref.read(basketProvider.notifier).applyTip(val);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
