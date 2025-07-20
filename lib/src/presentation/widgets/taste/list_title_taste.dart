import 'package:flutter/material.dart';

import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';

class ListTitleTaste extends StatelessWidget {
  final TasteModel taste;
  final VoidCallback? onTap;
  const ListTitleTaste({super.key, required this.taste, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(taste.name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.primaryButton,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.pets, color: Colors.white),
      ),
      trailing: Checkbox(
          value: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onChanged: (value) {}),
      onTap: onTap,
    );
  }
}
