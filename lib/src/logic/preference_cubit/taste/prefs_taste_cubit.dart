import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/data/models/models.dart';

part 'prefs_taste_state.dart';

class PrefsTasteCubit extends Cubit<PrefsTasteState> {
  final Box<TasteModel> tasteBox;
  final uuid = Uuid();
  PrefsTasteCubit({required this.tasteBox}) : super(PrefsTasteState.initial());

  void fetchTastes() {
    emit(state.copyWith(isLoading: true));
    try {
      final tastes = tasteBox.values.toList();
      emit(state.copyWith(tastes: tastes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void addTaste(String name) async {
    try {
      final taste = TasteModel(name: name, id: uuid.v4());
      await tasteBox.add(taste);
      emit(state.copyWith(tastes: tasteBox.values.toList()));
    } catch (e) {
      throw Exception('Failed to add taste: $e');
    }
  }

  void removeTaste(String id) {
    try {
      final tastes = tasteBox.values.toList();
      final index = tastes.indexWhere((taste) => taste.id == id);
      if (index != -1) {
        tasteBox.deleteAt(index);
      }
      emit(state.copyWith(tastes: tasteBox.values.toList()));
    } catch (e) {
      throw Exception('Failed to remove taste: $e');
    }
  }
}
