import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_data.freezed.dart';
part 'financial_data.g.dart';

@freezed
abstract class FinancialData with _$FinancialData {
  const factory FinancialData({required String month, required int value}) =
      _FinancialData;

  factory FinancialData.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataFromJson(json);
}
