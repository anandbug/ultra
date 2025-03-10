import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultra/bonds/data/models/financials.dart';
import 'package:ultra/bonds/data/models/issuer_details.dart';
import 'package:ultra/bonds/data/models/pros_and_cons.dart';

part 'company_details_model.freezed.dart';
part 'company_details_model.g.dart';

@freezed
abstract class CompanyDetailsModel with _$CompanyDetailsModel {
  const factory CompanyDetailsModel({
    required String logo,
    @JsonKey(name: 'company_name') required String companyName,
    required String description,
    required String isin,
    required String status,
    @JsonKey(name: 'pros_and_cons') required ProsAndCons prosAndCons,
    required Financials financials,
    @JsonKey(name: 'issuer_details') required IssuerDetails issuerDetails,
  }) = _CompanyDetailsModel;

  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetailsModelFromJson(json);
}
