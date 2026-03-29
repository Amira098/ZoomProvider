import 'package:injectable/injectable.dart';

import '../../../../core/models/drawer_model.dart';
import '../../../../core/network/common/api_result.dart';
import '../data_sources_imp/remote/remote_Terms_data_source.dart';


@injectable
class termsAndConditionsUseCase {
  final RemoteTermsDataSource remoteDataSource;
  termsAndConditionsUseCase(this.remoteDataSource);

  Future<Result<GeniralModel>> execute() async {
    return await remoteDataSource.termsAndConditions();
  }
}
