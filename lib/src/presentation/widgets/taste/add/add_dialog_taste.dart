import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/logic/preference_cubit/taste/prefs_taste_cubit.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/add/add_form_taste.dart';

class AddDialogTaste extends StatefulWidget {
  const AddDialogTaste({super.key});

  @override
  State<AddDialogTaste> createState() => _AddDialogTasteState();
}

class _AddDialogTasteState extends State<AddDialogTaste> {
  final String _addSuccessText = 'Taste added successfully.';
  final String _addErrorText = 'Failed to add taste. Please try again.';
  final String title = 'Add New Taste';
  final String titleButtonSave = 'Save';
  final String titleButtonCancel = 'Cancel';
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onSave() {
    if (_formKey.currentState!.validate()) {
      try {
        context.read<PrefsTasteCubit>().addTaste(
              nameController.text,
            );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_addSuccessText),
            backgroundColor: AppColors.accent,
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_addErrorText),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      } finally {
        Navigator.of(context).pop();
        nameController.clear();
      }
    }
  }

  void onCancel() {
    nameController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Platform.isIOS ? dialogIOS() : dialogAndroid(),
        ),
      ),
    );
  }

  Widget dialogAndroid() {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: TasteForm(
          formKey: _formKey,
          controller: nameController,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onSave,
          child: Text(titleButtonSave),
        ),
        TextButton(
          onPressed: onCancel,
          child: Text(titleButtonCancel),
        ),
      ],
    );
  }

  Widget dialogIOS() {
    return CupertinoAlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: TasteForm(
          formKey: _formKey,
          controller: nameController,
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: onSave,
          child: Text(titleButtonSave),
        ),
        CupertinoDialogAction(
          onPressed: onCancel,
          child: Text(titleButtonCancel),
        ),
      ],
    );
  }
}
