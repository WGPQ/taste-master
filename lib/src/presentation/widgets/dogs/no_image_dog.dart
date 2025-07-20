import 'package:flutter/material.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';

class NoImageDog extends StatelessWidget {
  const NoImageDog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimary,
      child: Center(
        child: Text(
          'No Image Available',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
    );
  }
}
