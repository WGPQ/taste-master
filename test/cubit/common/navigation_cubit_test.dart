import 'package:flutter_test/flutter_test.dart';
import 'package:taste_master_app/src/logic/common/navigation_bar_cubit.dart';

void main() {
  group('NavigationCubit', () {
    late NavigationCubit navigationCubit;

    setUp(() {
      navigationCubit = NavigationCubit();
    });

    tearDown(() {
      navigationCubit.close();
    });

    test('initial state is 0', () {
      expect(navigationCubit.state, equals(0));
    });

    test('setTab emits correct index', () {
      navigationCubit.setTab(2);
      expect(navigationCubit.state, equals(2));

      navigationCubit.setTab(3);
      expect(navigationCubit.state, equals(3));
    });
  });
}
