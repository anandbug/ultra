import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ultra/bonds/presentation/cubit/bond_details_cubit.dart';
import 'package:ultra/bonds/presentation/cubit/bond_details_state.dart';
import 'package:ultra/bonds/data/models/financial_data.dart';
import 'package:ultra/bonds/data/models/financials.dart';
import 'package:ultra/bonds/data/models/issuer_details.dart';
import 'package:ultra/bonds/data/models/pros_and_cons.dart';
import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';
import 'package:ultra/network/network_result.dart';

class MockBondsRepository extends Mock implements BondsRepository {}

void main() {
  late BondDetailsCubit cubit;
  late MockBondsRepository mockRepository;

  setUp(() {
    mockRepository = MockBondsRepository();
    cubit = BondDetailsCubit(mockRepository);
  });

  group('BondDetailsCubit', () {
    final companyDetails = CompanyDetailsModel(
      isin: '1',
      companyName: 'Company 1',
      description: 'Description 1',
      logo: 'logo1',
      status: 'active',
      prosAndCons: ProsAndCons(pros: ["pros"], cons: ["cons"]),
      issuerDetails: IssuerDetails(cin: 'Issuer 1', sector: "Sector 1"),
      financials: Financials(
        ebitda: [FinancialData(month: "Jan", value: 100)],
        revenue: [FinancialData(month: "Jan", value: 200)],
      ),
    );

    blocTest<BondDetailsCubit, BondsDetailsState>(
      'emits [loading, loaded] when loadCompanyDetails is successful',
      build: () {
        when(
          () => mockRepository.getCompanyDetails(),
        ).thenAnswer((_) async => NetworkSuccess(companyDetails));
        return cubit;
      },
      act: (cubit) => cubit.loadCompanyDetails(),
      expect:
          () => [
            const BondsDetailsState.loading(),
            BondsDetailsState.loaded(companyDetailsModel: companyDetails),
          ],
    );

    blocTest<BondDetailsCubit, BondsDetailsState>(
      'emits [loading, error] when loadCompanyDetails fails',
      build: () {
        when(() => mockRepository.getCompanyDetails()).thenAnswer(
          (_) async => NetworkResult.error(
            ErrorBody(code: -1, message: kDefaultErrorMsg),
            Exception(kDefaultErrorMsg),
          ),
        );

        return cubit;
      },
      act: (cubit) => cubit.loadCompanyDetails(),
      expect:
          () => [
            const BondsDetailsState.loading(),
            const BondsDetailsState.error(kDefaultErrorMsg),
          ],
    );

    blocTest<BondDetailsCubit, BondsDetailsState>(
      'emits [loading, error] when an exception is thrown',
      build: () {
        when(() => mockRepository.getCompanyDetails()).thenThrow(Exception());
        return cubit;
      },
      act: (cubit) => cubit.loadCompanyDetails(),
      expect:
          () => [
            const BondsDetailsState.loading(),
            const BondsDetailsState.error(kDefaultErrorMsg),
          ],
    );
  });
}
