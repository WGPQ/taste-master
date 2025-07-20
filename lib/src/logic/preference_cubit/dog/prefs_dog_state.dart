part of 'prefs_dog_cubit.dart';

class PrefsDogState {
  final ApiDogModel? selectedDog;
  final List<PrefsDogModel>? tasteDogs;
  final List<PrefsDogModel>? dogsByTaste;
  final bool isLoading;

  const PrefsDogState({
    this.selectedDog,
    this.tasteDogs,
    this.dogsByTaste,
    this.isLoading = false,
  });

  PrefsDogState copyWith({
    ApiDogModel? selectedDog,
    List<PrefsDogModel>? tasteDogs,
    List<PrefsDogModel>? dogsByTaste,
    bool? isLoading,
  }) {
    return PrefsDogState(
      selectedDog: selectedDog ?? this.selectedDog,
      tasteDogs: tasteDogs ?? this.tasteDogs,
      dogsByTaste: dogsByTaste ?? this.dogsByTaste,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory PrefsDogState.initial() {
    return const PrefsDogState(
      selectedDog: null,
      tasteDogs: [],
      dogsByTaste: [],
      isLoading: false,
    );
  }
}
