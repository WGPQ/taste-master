part of 'api_dog_cubit.dart';

class ApiDogState {
  final List<ApiDogModel>? dogList;
  final List<ApiDogModel>? filterResults;
  final int page;
  final int limit;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final bool isInitialized;

  const ApiDogState({
    required this.dogList,
    required this.filterResults,
    required this.page,
    required this.limit,
    required this.isLoading,
    this.isLoadingMore = false,
    required this.hasMore,
    this.isInitialized = false,
  });

  ApiDogState copyWith({
    List<ApiDogModel>? dogList,
    List<ApiDogModel>? filterResults,
    int? page,
    int? limit,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    bool? isInitialized,
  }) {
    return ApiDogState(
      dogList: dogList ?? this.dogList,
      filterResults: filterResults ?? this.filterResults,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  factory ApiDogState.initial() {
    return const ApiDogState(
      dogList: [],
      filterResults: [],
      page: 0,
      limit: 20,
      isLoading: false,
      isLoadingMore: false,
      hasMore: true,
      isInitialized: false,
    );
  }
}
