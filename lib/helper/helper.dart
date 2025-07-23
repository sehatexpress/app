import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/constants.dart';
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

void showUpdateDialog(BuildContext context, String title, String body) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () async {
                final url = Uri.parse(RemoteConfigConstant.playStoreURL);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child: const Text("Update Now"),
            ),
          ],
        ),
      ),
    );

bool isVersionOutdated(String current, String minimum) {
  List<int> curr = current.split('.').map(int.parse).toList();
  List<int> min = minimum.split('.').map(int.parse).toList();

  for (int i = 0; i < min.length; i++) {
    if (i >= curr.length || curr[i] < min[i]) return true;
    if (curr[i] > min[i]) return false;
  }
  return false;
}
