import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/logic/api_cubit/dog/api_dog_cubit.dart';
import 'package:taste_master_app/src/data/repositories/dogs/dogs_repository.dart';
import 'package:taste_master_app/src/data/models/api/dog/api_image_dog_model.dart';

import 'api_dog_cubit_test.mocks.dart';

@GenerateMocks([DogsRepository])
void main() {
  late MockDogsRepository mockDogsRepository;
  late ApiDogCubit apiDogCubit;

  setUp(() {
    mockDogsRepository = MockDogsRepository();
    apiDogCubit = ApiDogCubit(mockDogsRepository);
  });

  tearDown(() => apiDogCubit.close());

  final fakeDogs = [
    ApiDogModel(
      id: 1,
      name: 'Labrador Retriever',
      bredFor: 'Retrieving',
      breedGroup: 'Sporting',
      lifeSpan: '10 - 12 years',
      temperament: 'Gentle, Intelligent, Outgoing',
      origin: 'Canada',
      referenceImageId: 'B1uW7l5VX',
      image: ApiImageDogModel(
        id: 'Aoj2M3iqH',
        url: 'https://cdn2.thedogapi.com/images/Aoj2M3iqH.jpg',
        width: 800,
        height: 600,
      ),
    ),
    ApiDogModel(
      id: 2,
      name: 'German Shepherd',
      bredFor: 'Herding',
      breedGroup: 'Herding',
      lifeSpan: '9 - 13 years',
      temperament: 'Confident, Courageous, Smart',
      origin: 'Germany',
      referenceImageId: 'SJyBfg5NX',
      image: ApiImageDogModel(
        id: '4Fw1A7oD8',
        url: 'https://cdn2.thedogapi.com/images/4Fw1A7oD8.jpg',
        width: 800,
        height: 600,
      ),
    ),
  ];
  test('fetchDogs updates the state correctly with new data', () async {
    when(mockDogsRepository.fetchAllDogs(
      any,
      any,
      any,
    )).thenAnswer((invocation) async {
      final onSuccess =
          invocation.positionalArguments[1] as Function(List<ApiDogModel>);
      onSuccess(fakeDogs);
    });

    await apiDogCubit.fetchDogs();

    expect(apiDogCubit.state.filterResults, equals(fakeDogs));
    expect(apiDogCubit.state.isLoading, isFalse);
  });

  test('searchDogs updates dogList correctly with search results', () async {
    final searchResult = [
      ApiDogModel(
        id: 1,
        name: 'Labrador Retriever',
        bredFor: 'Retrieving',
        breedGroup: 'Sporting',
        lifeSpan: '10 - 12 years',
        temperament: 'Gentle, Intelligent, Outgoing',
        origin: 'Canada',
        referenceImageId: 'B1uW7l5VX',
        image: ApiImageDogModel(
          id: 'B1uW7l5VX',
          url: 'https://cdn2.thedogapi.com/images/B1uW7l5VX.jpg',
          width: 500,
          height: 600,
        ),
      )
    ];

    when(mockDogsRepository.searchDogs(
      any,
      any,
      any,
    )).thenAnswer((invocation) async {
      final onSuccess =
          invocation.positionalArguments[1] as Function(List<ApiDogModel>);
      onSuccess(searchResult);
    });

    await apiDogCubit.searchDogs('Labrador');

    expect(apiDogCubit.state.filterResults, equals(searchResult));
    expect(apiDogCubit.state.isLoading, isFalse);
  });
}
