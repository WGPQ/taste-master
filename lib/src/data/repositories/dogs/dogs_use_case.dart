import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/data/repositories/exceptions/fetch_data_exception.dart';

abstract class DogsUseCase {
  Future<void> fetchAllDogs(
    Map<String, String> params,
    Function(List<ApiDogModel>) data,
    Function(FetchDataException) exception,
  );

  Future<void> searchDogs(
    String query,
    Function(List<ApiDogModel>) data,
    Function(FetchDataException) exception,
  );
}
