import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra/bonds/presentation/cubit/bonds_list_state.dart';
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
          emit(
            BondsListState.loaded(
              items: result.data,
              searchQueryList: [],
              filteredItems: result.data,
            ),
          );
          break;
        case NetworkError():
          emit(BondsListState.error(result.body.message));
          break;
      }
    } catch (e) {
      emit(BondsListState.error(kDefaultErrorMsg));
    }
  }

  void searchBonds(String query) {
    final currentState = state;
    if (state is! Loaded) return;

    if (query.isEmpty && currentState is Loaded) {
      emit(
        BondsListState.loaded(
          items: currentState.items,
          searchQueryList: [],
          filteredItems: currentState.filteredItems,
        ),
      );
      return;
    }
    final queryList = query.split(" ");

    if (currentState is Loaded) {
      final filteredItems =
          currentState.items.where((item) {
            for (query in queryList) {
              final lowerQuery = query.toLowerCase();
              return item.isin.toLowerCase().contains(lowerQuery) ||
                  item.name.toLowerCase().contains(lowerQuery);
            }
            return false;
          }).toList();

      emit(
        BondsListState.loaded(
          items: currentState.items,
          searchQueryList: queryList,
          filteredItems: filteredItems,
        ),
      );
    }
  }
}
