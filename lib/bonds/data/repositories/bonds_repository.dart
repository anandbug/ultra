import 'package:ultra/bonds/data/models/bond_item_model.dart';
import 'package:ultra/bonds/data/models/bonds_list_response.dart';
import 'package:ultra/bonds/data/models/company_details_model.dart';
import 'package:ultra/network/api_end_points.dart';
import 'package:ultra/network/dio_client.dart';
import 'package:ultra/network/network_result.dart';
import 'package:ultra/network/network_result_wrapper.dart';

abstract class BondsRepository {
  Future<NetworkResult<List<BondItem>>> getMarketItems();
  Future<NetworkResult<CompanyDetailsModel>> getCompanyDetails();
}

class BondsRepositoryImpl implements BondsRepository {
  final DioClient _dioClient;

  BondsRepositoryImpl(this._dioClient);

  @override
  Future<NetworkResult<List<BondItem>>> getMarketItems() async {
    return NetworkResultWrapper.getResult(() async {
      final response = await _dioClient.dio.get(ApiEndPoints.listingUrl);
      return NetworkSuccess(BondsListResponse.fromJson(response.data).data);
    });
  }

  @override
  Future<NetworkResult<CompanyDetailsModel>> getCompanyDetails() async {
    return NetworkResultWrapper.getResult(() async {
      final response = await _dioClient.dio.get(ApiEndPoints.companyDetailUrl);
      return NetworkSuccess(CompanyDetailsModel.fromJson(response.data));
    });
  }
}
