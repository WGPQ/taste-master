import 'package:flutter/material.dart';

class TasteForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;

  const TasteForm({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Taste Name',
            isDense: true,
          ),
          autocorrect: true,
          autofocus: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a taste name';
            }
            return null;
          },
        ),
      ),
    );
  }
}
