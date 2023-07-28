
import 'package:taskhub/api_calls/dio_clients.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_api_endpoints.dart';

class FetchUserData {
  static Future<bool> userRegisterOrNot (String uid) async {
    final response = await getIt.get<DioApiClient>().getRequest(ConstantsApiEndPoints.alreadyRegisterOrNot,uid);
    if (response?.statusCode == 200) return true;
    return false;
  }

  static Future<bool> userRegister (Map<String,dynamic> userDetailsModel) async {
    final response = await getIt.get<DioApiClient>().postRequest(ConstantsApiEndPoints.registerUser, userDetailsModel);
    if (response?.statusCode == 201) return true;
    return false;
  }

  static Future<bool> profileUpload (Map<String,dynamic> data) async {
    final response = await getIt.get<DioApiClient>().putRequest(ConstantsApiEndPoints.profileUpload, data);
    if (response?.statusCode == 200) return true;
    return false;
  }
}