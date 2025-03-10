import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_financial.freezed.dart';
part 'company_financial.g.dart';

@freezed
abstract class CompanyFinancials with _$CompanyFinancials {
  const factory CompanyFinancials({
    required String month,
    required double ebitda,
    required double revenue,
  }) = _CompanyFinancials;

  factory CompanyFinancials.fromJson(Map<String, dynamic> json) =>
      _$CompanyFinancialsFromJson(json);
}
