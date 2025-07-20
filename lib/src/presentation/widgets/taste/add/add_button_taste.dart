import 'package:flutter/material.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/presentation/widgets/modals/base_modal.dart';

class AddButtonTaste extends StatelessWidget {
  final double? size;
  final double? borderRadius;

  const AddButtonTaste({
    super.key,
    this.size = 30.0,
    this.borderRadius = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ModalHelper.addNewTasteModal(context: context);
      },
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          ),
          child: Icon(Icons.add, color: Colors.white)),
    );
  }
}
