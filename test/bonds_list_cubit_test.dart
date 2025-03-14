import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ultra/bonds/presentation/cubit/bonds_list_cubit.dart';
import 'package:ultra/bonds/presentation/cubit/bonds_list_state.dart';
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
      BondItem(
        name: 'Hella Chemical Market Private Limited',
        isin: 'INE06E501754',
        logo: 'logo1',
        rating: 'AAA',
      ),
      BondItem(
        name: 'Hella Chemical Market Private Limited',
        isin: 'INE06E508653',
        logo: 'logo2',
        rating: 'AAA',
      ),
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
            BondsListState.loaded(
              items: bondItems,
              searchQueryList: [],
              filteredItems: bondItems,
            ),
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

    blocTest<BondsListCubit, BondsListState>(
      'emits [loaded] with filtered items when searchBonds is called with name search',
      build: () {
        return cubit;
      },
      seed:
          () => BondsListState.loaded(
            items: bondItems,
            searchQueryList: [],
            filteredItems: bondItems,
          ),
      act: (cubit) => cubit.searchBonds('1754'),
      expect:
          () => [
            BondsListState.loaded(
              items: bondItems,
              searchQueryList: ['1754'],
              filteredItems: [bondItems[0]],
            ),
          ],
    );

    blocTest<BondsListCubit, BondsListState>(
      'emits [loaded] with filtered items when searchBonds is called with isn search',
      build: () {
        return cubit;
      },
      seed:
          () => BondsListState.loaded(
            items: bondItems,
            searchQueryList: [],
            filteredItems: bondItems,
          ),
      act: (cubit) => cubit.searchBonds('Hella'),
      expect:
          () => [
            BondsListState.loaded(
              items: bondItems,
              searchQueryList: ['Hella'],
              filteredItems: bondItems,
            ),
          ],
    );

    blocTest<BondsListCubit, BondsListState>(
      'emits [loaded] with empty filtered items when searchBonds does not match any item',
      build: () {
        return cubit;
      },
      seed:
          () => BondsListState.loaded(
            items: bondItems,
            searchQueryList: [],
            filteredItems: bondItems,
          ),
      act: (cubit) => cubit.searchBonds('Nonexistent Bond'),
      expect:
          () => [
            BondsListState.loaded(
              items: bondItems,
              searchQueryList: ['Nonexistent', 'Bond'],
              filteredItems: [],
            ),
          ],
    );
  });
}
