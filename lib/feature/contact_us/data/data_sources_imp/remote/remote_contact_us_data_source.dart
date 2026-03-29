
import '../../../../../core/network/common/api_result.dart';
import '../../models/contact_us.dart';
import '../../models/services_faqs_model.dart';


abstract class RemoteContactUsDataSource {
  Future<Result<ContactModel>> contactUs({
    required String subject,
  required  String name,
    required String email,
    required  String phone,
    required  String message,

  });
  Future<Result<ServicesFaqsModel>> servicesFaqs();
}
