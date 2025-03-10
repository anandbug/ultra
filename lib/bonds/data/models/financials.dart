import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultra/bonds/data/models/financial_data.dart';

part 'financials.freezed.dart';
part 'financials.g.dart';

@freezed
abstract class Financials with _$Financials {
  const factory Financials({
    required List<FinancialData> ebitda,
    required List<FinancialData> revenue,
    required int netIncome,
  }) = _Financials;

  factory Financials.fromJson(Map<String, dynamic> json) =>
      _$FinancialsFromJson(json);
}
