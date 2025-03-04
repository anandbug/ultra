import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ultra/bonds/data/models/bond_item_model.dart';

part 'bonds_list_state.freezed.dart';

@freezed
sealed class BondsListState with _$BondsListState {
  const factory BondsListState.loading() = Loading;
  const factory BondsListState.loaded(List<BondItem> items) = Loaded;
  const factory BondsListState.error(String message) = Error;
}
