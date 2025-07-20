part of 'prefs_taste_cubit.dart';

class PrefsTasteState {
  final List<TasteModel> tastes;
  final bool isLoading;
  final String errorMessage;

  PrefsTasteState({
    required this.tastes,
    required this.isLoading,
    required this.errorMessage,
  });

  PrefsTasteState copyWith({
    List<TasteModel>? tastes,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PrefsTasteState(
      tastes: tastes ?? this.tastes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory PrefsTasteState.initial() {
    return PrefsTasteState(
      tastes: [],
      isLoading: false,
      errorMessage: '',
    );
  }
}
