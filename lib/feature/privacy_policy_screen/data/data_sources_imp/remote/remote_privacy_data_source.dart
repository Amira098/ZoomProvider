
import '../../../../../core/models/drawer_model.dart';
import '../../../../../core/network/common/api_result.dart';


abstract class RemotePrivacyDataSource {
  Future<Result<GeniralModel>> privacy();


}
