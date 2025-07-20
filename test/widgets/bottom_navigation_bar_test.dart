import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/presentation/widgets/widgets.dart';
import 'package:taste_master_app/src/logic/common/navigation_bar_cubit.dart';

class MockNavigationCubit extends Mock implements NavigationCubit {}

void main() {
  late MockNavigationCubit mockCubit;

  setUp(() {
    mockCubit = MockNavigationCubit();
    when(() => mockCubit.state).thenReturn(0);
    whenListen(mockCubit, Stream<int>.fromIterable([0]));
  });

  testWidgets('Correctly renders the BottomNavigationBar items',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<NavigationCubit>.value(
          value: mockCubit,
          child: const Scaffold(
            bottomNavigationBar: CustomBottomNavigationBar(),
          ),
        ),
      ),
    );

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Taste'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Calls setTab when an item is tapped',
      (WidgetTester tester) async {
    when(() => mockCubit.setTab(any())).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<NavigationCubit>.value(
          value: mockCubit,
          child: const Scaffold(
            bottomNavigationBar: CustomBottomNavigationBar(),
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.category));
    await tester.pump();

    verify(() => mockCubit.setTab(1)).called(1);
  });
}
