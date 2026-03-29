
import '../../../../../core/models/drawer_model.dart';
import '../../../../../core/network/common/api_result.dart';


abstract class RemoteTermsDataSource {
  Future<Result<GeniralModel>> termsAndConditions();

}
