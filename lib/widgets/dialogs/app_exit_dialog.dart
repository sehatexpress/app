import 'package:flutter/material.dart';

import '../../config/string_constants.dart';
import 'alert_dialog_model.dart';

@immutable
class AppExitDialog extends AlertDialogModel<bool> {
  const AppExitDialog()
      : super(
          title: 'Exit App!',
          message: 'Do you want to really exit the app?',
          buttons: const {
            Strings.no: false,
            Strings.yes: true,
          },
        );
}
