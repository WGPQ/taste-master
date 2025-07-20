import 'package:flutter/material.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/add/add_dialog_taste.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/list_taste_to_save.dart';

class ModalHelper {
  static void saveDogBottomSheetModal({
    required BuildContext context,
  }) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: AppColors.accent.withOpacity(0.5),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return ListTasteToSave(scrollController: scrollController);
            },
          );
        },
      );

  static void addNewTasteModal({
    required BuildContext context,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: AppColors.accent.withOpacity(0.5),
        builder: (context) => AddDialogTaste(),
      );
}
