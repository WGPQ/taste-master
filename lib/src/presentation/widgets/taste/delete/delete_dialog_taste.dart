import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';
import 'package:taste_master_app/src/logic/preference_cubit/taste/prefs_taste_cubit.dart';

class DeleteDialogTaste extends StatefulWidget {
  final Widget child;
  final TasteModel taste;
  const DeleteDialogTaste({
    super.key,
    required this.child,
    required this.taste,
  });

  @override
  State<DeleteDialogTaste> createState() => _DeleteDialogTasteState();
}

class _DeleteDialogTasteState extends State<DeleteDialogTaste> {
  TasteModel get taste => widget.taste;
  final String _deleteConfirmationText =
      'Are you sure you want to delete this taste?';
  final String _deleteSuccessText = 'Taste deleted successfully.';
  final String _deleteErrorText = 'Failed to delete taste. Please try again.';
  final String _deleteTitle = 'Delete Taste';
  final String _deleteButtonText = 'Delete';
  final String _cancelButtonText = 'Cancel';

  bool onDelete() {
    try {
      context.read<PrefsTasteCubit>().removeTaste(taste.id!);
      context.read<PrefsDogCubit>().removeAllDogByTaste(taste.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_deleteSuccessText),
          backgroundColor: AppColors.accent,
          duration: Duration(seconds: 2),
        ),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_deleteErrorText),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(taste.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 8),
            Text(_deleteButtonText, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) {
            return Platform.isIOS ? iosDialog() : androidDialog();
          },
        );
        if (confirm == true) {
          return onDelete();
        }
        return false;
      },
      child: widget.child,
    );
  }

  Widget androidDialog() {
    return AlertDialog(
      title: Text(_deleteTitle),
      content: content(),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(_deleteButtonText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(_cancelButtonText),
        ),
      ],
    );
  }

  Widget iosDialog() {
    return CupertinoAlertDialog(
      title: Text(_deleteTitle),
      content: content(),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(_deleteButtonText),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(_cancelButtonText),
        ),
      ],
    );
  }

  Widget content() {
    return RichText(
        text: TextSpan(
      text: _deleteConfirmationText,
      style: TextStyle(
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: ' ${taste.name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ));
  }
}
