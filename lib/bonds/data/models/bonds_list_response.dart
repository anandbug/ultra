import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultra/bonds/data/models/bond_item_model.dart';

part 'bonds_list_response.freezed.dart';
part 'bonds_list_response.g.dart';

@freezed
abstract class BondsListResponse with _$BondsListResponse {
  const factory BondsListResponse({@Default([]) List<BondItem> data}) =
      _BondsListResponse;

  factory BondsListResponse.fromJson(Map<String, dynamic> json) =>
      _$BondsListResponseFromJson(json);
}
