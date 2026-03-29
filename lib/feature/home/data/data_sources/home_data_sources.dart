import '../../../../core/network/common/api_result.dart';
import '../model/home_model.dart';
abstract class HomeDataSources {
  Future<Result<HomeModel>> getHomeData();
}
