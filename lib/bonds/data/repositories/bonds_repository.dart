import 'package:ultra/bonds/data/models/bond_item_model.dart';
import 'package:ultra/bonds/data/models/bonds_list_response.dart';
import 'package:ultra/network/api_end_points.dart';
import 'package:ultra/network/dio_client.dart';
import 'package:ultra/network/network_result.dart';
import 'package:ultra/network/network_result_wrapper.dart';
import 'package:ultra/utils/num_extensions.dart';

abstract class BondsRepository {
  Future<NetworkResult<List<BondItem>>> getMarketItems();
}

class BondsRepositoryImpl implements BondsRepository {
  final DioClient _dioClient;

  BondsRepositoryImpl(this._dioClient);

  @override
  Future<NetworkResult<List<BondItem>>> getMarketItems() async {
    return NetworkResultWrapper.getResult(() async {
      await Future.delayed(500.milliseconds);
      final response = await _dioClient.dio.get(ApiEndPoints.listingUrl);
      return NetworkSuccess(BondsListResponse.fromJson(response.data).data);
    });
  }
}
