import 'package:flutter/material.dart';

import '../models/address_model.dart';
import '../widgets/auth/add_edit_address_widget.dart';

// generic dialog for root
Future<Object?> genericDialogTransitionForTopBar({
  required BuildContext context,
  required Widget widget,
}) => showGeneralDialog(
  context: context,
  barrierDismissible: true,
  transitionDuration: const Duration(milliseconds: 500),
  barrierLabel: MaterialLocalizations.of(context).dialogLabel,
  barrierColor: Colors.black.withAlpha(127),
  pageBuilder: (context, _, _) => Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width,
        child: Card(margin: EdgeInsets.zero, child: widget),
      ),
    ],
  ),
  transitionBuilder: (context, animation, _, child) => SlideTransition(
    position: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ).drive(Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero)),
    child: child,
  ),
);

// open bottombar for
void openBottombarForAddress({
  required BuildContext context,
  required AddressModel? model,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.grey.shade50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 320),
          child: AddEditAddressWidget(address: model),
        ),
      ),
    ),
  );
}