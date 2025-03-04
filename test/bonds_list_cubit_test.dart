// import 'package:bloc_test/bloc_test.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:ultra/bonds/cubit/bonds_list_cubit.dart';
// import 'package:ultra/bonds/cubit/bonds_list_state.dart';
// import 'package:ultra/bonds/data/models/bond_item_model.dart';
// import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
// import 'package:ultra/network/dio_client.dart';

// class MockDioClient extends Mock implements DioClient {}

// class MockDio extends Mock implements Dio {}

// class MockResponse extends Mock implements Response {}

// void main() {
//   late BondsListCubit cubit;
//   late MockDioClient mockDioClient;
//   late BondsRepository repository;
//   late MockDio mockDio;

//   setUp(() {
//     mockDioClient = MockDioClient();
//     mockDio = MockDio();
//     when(mockDioClient.dio).thenReturn(mockDio);
//     repository = BondsRepositoryImpl(mockDioClient);
//     cubit = BondsListCubit(repository);
//   });

//   tearDown(() {
//     cubit.close();
//   });

//   group('BondsListCubit', () {
//     final marketItems = [
//       BondItem(
//         isin: 'INE06E507172',
//         rating: 'AAA',
//         name: 'Hella Infra Market Private Limited',
//       ),
//     ];

//     blocTest<BondsListCubit, BondsListState>(
//       'emits [loading, loaded] when loadMarketItems succeeds',
//       build: () {
//         // Stub the GET request to return a successful response
//         final response = MockResponse();
//         when(
//           response.data,
//         ).thenReturn(marketItems.map((item) => item.toJson()).toList());
//         when(mockDio.get('/market-items')).thenAnswer((_) async => response);
//         return cubit;
//       },
//       act: (cubit) => cubit.loadMarketItems(),
//       expect:
//           () => [
//             const BondsListState.loading(),
//             BondsListState.loaded(marketItems),
//           ],
//     );

//     blocTest<BondsListCubit, BondsListState>(
//       'emits [loading, error] when loadMarketItems fails',
//       build: () {
//         when(mockDioClient.dio.get('')).thenThrow(
//           DioException(
//             requestOptions: RequestOptions(path: ''),
//             message: 'Network error',
//           ),
//         );
//         return cubit;
//       },
//       act: (cubit) => cubit.loadMarketItems(),
//       expect:
//           () => [
//             const BondsListState.loading(),
//             const BondsListState.error('Network error'),
//           ],
//     );
//   });
// }

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ultra/bonds/cubit/bonds_list_cubit.dart';
import 'package:ultra/bonds/cubit/bonds_list_state.dart';
import 'package:ultra/bonds/data/models/bond_item_model.dart';
import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
import 'package:ultra/network/network_result.dart';

class MockBondsRepository extends Mock implements BondsRepository {}

void main() {
  late BondsListCubit cubit;
  late MockBondsRepository mockRepository;

  setUp(() {
    mockRepository = MockBondsRepository();
    cubit = BondsListCubit(mockRepository);
  });

  group('BondsListCubit', () {
    final bondItems = [
      BondItem(name: 'Bond 1', isin: 'ISIN1', logo: 'logo1', rating: 'A'),
    ];

    blocTest<BondsListCubit, BondsListState>(
      'emits [loading, loaded] when loadMarketItems is successful',
      build: () {
        when(
          () => mockRepository.getMarketItems(),
        ).thenAnswer((_) async => NetworkResult.success(bondItems));
        return cubit;
      },
      act: (cubit) => cubit.loadMarketItems(),
      expect:
          () => [
            const BondsListState.loading(),
            BondsListState.loaded(bondItems),
          ],
    );

    blocTest<BondsListCubit, BondsListState>(
      'emits [loading, error] when loadMarketItems fails',
      build: () {
        when(() => mockRepository.getMarketItems()).thenAnswer(
          (_) async => NetworkResult.error(
            ErrorBody(code: -1, message: kDefaultErrorMsg),
            Exception(kDefaultErrorMsg),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadMarketItems(),
      expect:
          () => [
            const BondsListState.loading(),
            const BondsListState.error(kDefaultErrorMsg),
          ],
    );

    blocTest<BondsListCubit, BondsListState>(
      'emits [loading, error] when an exception is thrown',
      build: () {
        when(() => mockRepository.getMarketItems()).thenThrow(Exception());
        return cubit;
      },
      act: (cubit) => cubit.loadMarketItems(),
      expect:
          () => [
            const BondsListState.loading(),
            const BondsListState.error(kDefaultErrorMsg),
          ],
    );

    blocTest<BondsListCubit, BondsListState>(
      'emits [loading, error] when an FormatException is thrown',
      build: () {
        when(
          () => mockRepository.getMarketItems(),
        ).thenThrow(FormatException());
        return cubit;
      },
      act: (cubit) => cubit.loadMarketItems(),
      expect:
          () => [
            const BondsListState.loading(),
            const BondsListState.error(kDefaultErrorMsg),
          ],
    );
  });
}
