import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultra/bonds/cubit/bond_details_state.dart';
import 'package:ultra/bonds/data/repositories/bonds_repository.dart';
import 'package:ultra/network/network_result.dart';

class BondDetailsCubit extends Cubit<BondsDetailsState> {
  final BondsRepository _repository;

  BondDetailsCubit(this._repository) : super(const BondsDetailsState.loading());

  Future<void> loadCompanyDetails() async {
    emit(const BondsDetailsState.loading());
    try {
      final result = await _repository.getCompanyDetails();
      switch (result) {
        case NetworkSuccess():
          emit(BondsDetailsState.loaded(companyDetailsModel: result.data));
          break;
        case NetworkError():
          emit(BondsDetailsState.error(result.body.message));
          break;
      }
    } catch (e) {
      emit(BondsDetailsState.error(kDefaultErrorMsg));
    }
  }
}
