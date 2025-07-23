import 'package:flutter/material.dart';

import '../../config/string_constants.dart';
import 'alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
          title: '${Strings.delete} $titleOfObjectToDelete',
          message:
              '${Strings.genericAlertDescription} ${Strings.delete} $titleOfObjectToDelete?',
          buttons: const {
            Strings.cancle: false,
            Strings.delete: true,
          },
        );
}
