import '../../../../core/network/common/api_result.dart';
import '../model/all_requests_model.dart';
import '../model/home_model.dart';
import '../model/requests_details_model.dart';
abstract class HomeDataSources {
  Future<Result<HomeModel>> getHomeData();
  Future<Result<AllRequestsModel>> getAllRequests();
  Future<Result<RequestsDetailsModel>> getRequestsDetails(int requestsId);
}
