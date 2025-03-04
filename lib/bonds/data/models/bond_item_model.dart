import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:ultra/bonds/listing/domain/entities/bond_item_entity.dart';

part 'bond_item_model.freezed.dart';
part 'bond_item_model.g.dart';

@freezed
abstract class BondItem with _$BondItem {
  const factory BondItem({
    @Default("") String logo,
    required String isin,
    @Default("") String rating,
    @Default("N/A") @JsonKey(name: 'company_name') String name,
    @Default([]) List<String> tags,
  }) = _BondItem;

  factory BondItem.fromJson(Map<String, dynamic> json) =>
      _$BondItemFromJson(json);
}

// class BondItemModel extends BondItemEntity {
//   const BondItemModel({
//     required super.isin,
//     required super.rating,
//     required super.name,
//   });

//   factory BondItemModel.fromJson(Map<String, dynamic> json) => BondItemModel(
//     isin: json['isin'] as String,
//     rating: json['rating'] as String,
//     name: json['name'] as String,
//   );

//   factory BondItemModel.fromEntity(BondItemEntity entity) => BondItemModel(
//     isin: entity.isin,
//     rating: entity.rating,
//     name: entity.name,
//   );
// }
