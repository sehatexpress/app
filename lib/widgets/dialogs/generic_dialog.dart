import 'package:flutter/material.dart';

import '../../config/string_constants.dart';
import 'alert_dialog_model.dart';

@immutable
class GenericDialog extends AlertDialogModel<bool> {
  GenericDialog(String title)
      : super(
          title: title,
          message: '${Strings.genericAlertDescription}${title.toLowerCase()}?',
          buttons: {
            Strings.cancle: false,
            title: true,
          },
        );
}
