import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/data/models/api/dog/api_dog_model.dart';
import 'package:taste_master_app/src/data/repositories/dogs/dogs_repository.dart';

part 'api_dog_state.dart';

class ApiDogCubit extends Cubit<ApiDogState> {
  final DogsRepository _repository;
  final int _totalDogs = 170; // Assuming total number of dogs is 170

  ApiDogCubit(this._repository) : super(ApiDogState.initial());

  Future<void> fetchDogs({bool refresh = false}) async {
    try {
      if (refresh) {
        emit(ApiDogState.initial());
      }
      Map<String, String> queryParams = {
        'page': state.page.toString(),
        'limit': state.limit.toString(),
      };
      if (!state.isInitialized) {
        emit(state.copyWith(isLoading: true));
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }
      await _repository.fetchAllDogs(queryParams, (data) {
        final currentList = state.dogList ?? [];
        final existingIds = currentList.map((d) => d.id).toSet();
        final newDogs =
            data.where((dog) => !existingIds.contains(dog.id)).toList();
        List<ApiDogModel> dogs = [...currentList, ...newDogs];
        emit(state.copyWith(
          dogList: dogs,
          filterResults: dogs,
          isLoading: false,
          isLoadingMore: false,
          page: state.page + 1,
          hasMore: state.dogList!.length > _totalDogs,
          isInitialized: true,
        ));
      }, (exception) {
        emit(state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          dogList: [],
          filterResults: [],
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        dogList: [],
        filterResults: [],
      ));
    }
  }

  Future<void> searchDogs(String query) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final searchTerm = query.toLowerCase();
    if (searchTerm.isEmpty) {
      emit(state.copyWith(
        isLoading: false,
        filterResults: state.dogList ?? [],
      ));
      return;
    }
    try {
      await _repository.searchDogs(query, (data) {
        final filterResult = data.where((dog) {
          return dog.name.toLowerCase().contains(searchTerm);
        }).toList();
        emit(state.copyWith(
          isLoading: false,
          filterResults: filterResult,
        ));
      }, (exception) {
        emit(state.copyWith(
          isLoading: false,
          filterResults: [],
        ));
      });
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        filterResults: [],
      ));
    }
    // var filterResult = state.dogList!.where((dog) {
    //   return dog.name.toLowerCase().contains(searchTerm);
    // }).toList();
    // emit(state.copyWith(
    //   isLoading: false,
    //   filterResults: filterResult,
    // ));
  }
}
