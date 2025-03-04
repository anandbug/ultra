import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra/bonds/cubit/bonds_list_state.dart';
import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
import 'package:ultra/network/network_result.dart';

class BondsListCubit extends Cubit<BondsListState> {
  final BondsRepository _repository;

  BondsListCubit(this._repository) : super(const BondsListState.loading());

  Future<void> loadMarketItems() async {
    emit(const BondsListState.loading());
    try {
      final result = await _repository.getMarketItems();
      switch (result) {
        case NetworkSuccess():
          emit(BondsListState.loaded(result.data));
          break;
        case NetworkError():
          emit(BondsListState.error(result.body.message));
          break;
      }
    } catch (e) {
      emit(BondsListState.error(kDefaultErrorMsg));
    }
  }
}
