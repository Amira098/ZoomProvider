import 'package:injectable/injectable.dart';

import '../../../../core/models/drawer_model.dart';
import '../../../../core/network/common/api_result.dart';

import '../data_sources_imp/remote/remote_about_us_data_source.dart'; // لو غلط، غيريه لـ remote_privacy_data_source.dart

@injectable
class AboutUsUseCase {
  final RemoteAboutUsDataSource remoteDataSource;

  AboutUsUseCase(this.remoteDataSource);

  Future<Result<GeniralModel>> execute() async {
    return await remoteDataSource.AboutUs();
  }
}
