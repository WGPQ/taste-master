import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/add/add_form_taste.dart';

void main() {
  late GlobalKey<FormState> formKey;
  late TextEditingController controller;

  setUp(() {
    formKey = GlobalKey<FormState>();
    controller = TextEditingController();
  });

  testWidgets('Shows error if the field is empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TasteForm(
            formKey: formKey,
            controller: controller,
          ),
        ),
      ),
    );

    formKey.currentState!.validate();
    await tester.pump();

    expect(find.text('Please enter a taste name'), findsOneWidget);
  });

  testWidgets('Validates correctly when the field has text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TasteForm(
            formKey: formKey,
            controller: controller,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'New Taste');

    final isValid = formKey.currentState!.validate();
    await tester.pump();

    expect(isValid, isTrue);
    expect(find.text('Please enter a taste name'), findsNothing);
  });
}
