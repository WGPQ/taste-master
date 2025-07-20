import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/data/models/models.dart';

part 'prefs_dog_state.dart';

class PrefsDogCubit extends Cubit<PrefsDogState> {
  final Box<PrefsDogModel> tasteDogBox;
  final uuid = Uuid();
  PrefsDogCubit(this.tasteDogBox) : super(PrefsDogState.initial());
  void selectDog(ApiDogModel dog) => emit(state.copyWith(selectedDog: dog));
  void fetchDogTastes() {
    emit(state.copyWith(isLoading: true));
    try {
      final tasteDogs = tasteDogBox.values.toList();
      emit(state.copyWith(tasteDogs: tasteDogs, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void getDogByTaste(String tasteId) {
    emit(state.copyWith(isLoading: true));
    try {
      final tasteDogs =
          tasteDogBox.values.where((dog) => dog.tasteId == tasteId).toList();
      emit(state.copyWith(dogsByTaste: tasteDogs, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  bool isDogLiked(int? dogId) {
    if (dogId == null) return false;
    return state.tasteDogs!.any((taste) => taste.dog?.id == dogId);
  }

  void saveDogTaste(String tasteId) {
    try {
      if (state.selectedDog == null) return;
      final model = PrefsDogModel(
        id: uuid.v4(),
        tasteId: tasteId,
        dog: state.selectedDog!,
      );
      tasteDogBox.add(model);
      emit(state.copyWith(
        selectedDog: null,
        tasteDogs: tasteDogBox.values.toList(),
      ));
    } catch (e) {
      throw Exception('Failed to save dog taste: $e');
    }
  }

  void removeDogTaste(int? dogId) {
    try {
      if (dogId == null) return;
      final index = state.tasteDogs!.indexWhere((dog) => dog.dog?.id == dogId);
      if (index != -1) {
        tasteDogBox.deleteAt(index);
        emit(state.copyWith(tasteDogs: tasteDogBox.values.toList()));
      }
    } catch (e) {
      throw Exception('Failed to remove dog taste: $e');
    }
  }

  void removeAllDogByTaste(String tasteId) {
    try {
      final keysToDelete = tasteDogBox.keys
          .where((key) => tasteDogBox.get(key)?.tasteId == tasteId)
          .toList();
      tasteDogBox.deleteAll(keysToDelete);
      emit(state.copyWith(tasteDogs: tasteDogBox.values.toList()));
    } catch (e) {
      log('Failed to remove all dogs by taste: $e');
    }
  }
}
