import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';

part 'bond_details_state.freezed.dart';

@freezed
sealed class BondsDetailsState with _$BondsDetailsState {
  const factory BondsDetailsState.loading() = CompanyDetailsLoading;
  const factory BondsDetailsState.loaded({
    required CompanyDetailsModel companyDetailsModel,
  }) = CompanyDetailsLoaded;
  const factory BondsDetailsState.error(String message) = CompanyDetailsError;
}
