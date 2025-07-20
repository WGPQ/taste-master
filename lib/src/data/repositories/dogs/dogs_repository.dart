import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/core/constants/api_dog.dart';
import 'package:taste_master_app/src/data/repositories/dogs/dogs_use_case.dart';
import 'package:taste_master_app/src/data/repositories/exceptions/fetch_data_exception.dart';

class DogsRepository implements DogsUseCase {
  static headers() => {
        'x-api-key': ApiDogConstants.apiKey,
        'Content-Type': 'application/json',
      };

  @override
  Future<void> fetchAllDogs(
    Map<String, String> params,
    Function(List<ApiDogModel>) data,
    Function(FetchDataException) exception,
  ) async {
    try {
      String queryParams = Uri(queryParameters: params).query;
      final response = await http.get(
          Uri.parse('${ApiDogConstants.baseApiUrl}/breeds?$queryParams'),
          headers: await headers());
      final responseJson = json.decode(response.body);
      final statusCode = response.statusCode;
      switch (statusCode) {
        case 200:
          data(dogsFromJson(response.body));
          break;
        case 400:
          exception(FetchDataException(
              error: responseJson['error'] ?? 'Bad Request',
              statusCode: statusCode));
          break;
        case 401:
          exception(FetchDataException(
              error: 'Unauthorized', statusCode: statusCode));
          break;
        case 404:
          exception(FetchDataException(
              error: responseJson['error'] ?? 'Not Found',
              statusCode: statusCode));
        default:
          exception(FetchDataException(
              error:
                  'Error occurred while communication with server with status code : $statusCode'));
          break;
      }
    } on SocketException {
      exception(FetchDataException(error: 'No Internet Connection'));
    } catch (e) {
      log('Something went wrong fetchAllDogs !! ${e.toString()}');
      exception(FetchDataException(error: 'Something went wrong!!'));
    }
  }

  @override
  Future<void> searchDogs(
    String query,
    Function(List<ApiDogModel>) data,
    Function(FetchDataException) exception,
  ) async {
    try {
      String queryParams = Uri(queryParameters: {'q': query}).query;
      final response = await http.get(
          Uri.parse('${ApiDogConstants.baseApiUrl}/breeds/search?$queryParams'),
          headers: await headers());
      final responseJson = json.decode(response.body);
      final statusCode = response.statusCode;
      switch (statusCode) {
        case 200:
          data(dogsFromJson(response.body));
          break;
        case 400:
          exception(FetchDataException(
              error: responseJson['error'] ?? 'Bad Request',
              statusCode: statusCode));
          break;
        case 401:
          exception(FetchDataException(
              error: 'Unauthorized', statusCode: statusCode));
          break;
        case 404:
          exception(FetchDataException(
              error: responseJson['error'] ?? 'Not Found',
              statusCode: statusCode));
        default:
          exception(FetchDataException(
              error:
                  'Error occurred while communication with server with status code : $statusCode'));
          break;
      }
    } on SocketException {
      exception(FetchDataException(error: 'No Internet Connection'));
    } catch (e) {
      log('Something went wrong searchDogs !! ${e.toString()}');
      exception(FetchDataException(error: 'Something went wrong!!'));
    }
  }
}
