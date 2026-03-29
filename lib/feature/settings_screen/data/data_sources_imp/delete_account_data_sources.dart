import '../../../../core/network/common/api_result.dart';
import '../model/delete_model.dart';

abstract class DeleteDataSources {
  Future<Result<DeleteModel>>deleteAccount();
}