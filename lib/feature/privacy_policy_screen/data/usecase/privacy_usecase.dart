import 'package:injectable/injectable.dart';

import '../../../../core/models/drawer_model.dart';
import '../../../../core/network/common/api_result.dart';

import '../data_sources_imp/remote/remote_privacy_data_source.dart'; // لو غلط، غيريه لـ remote_privacy_data_source.dart

@injectable
class PrivacyUseCase {
  final RemotePrivacyDataSource remoteDataSource;

  PrivacyUseCase(this.remoteDataSource);

  Future<Result<GeniralModel>> execute() async {
    return await remoteDataSource.privacy();
  }
}
