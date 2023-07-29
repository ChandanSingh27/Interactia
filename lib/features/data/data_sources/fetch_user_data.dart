
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskhub/api_calls/dio_clients.dart';
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_api_endpoints.dart';

class FetchUserData {

  static Future<bool> userAlreadyRegisterOrNot (String uid) async {
    final response = await getIt.get<DioApiClient>().getRequest(ConstantsApiEndPoints.alreadyRegisterOrNot,uid);
    if (response?.statusCode == 200) return true;
    return false;
  }

  static Future<bool> createNewUser (Map<String,dynamic> userDetailsModel) async {
    final response = await getIt.get<DioApiClient>().postRequest(ConstantsApiEndPoints.registerUser, userDetailsModel);
    if (response?.statusCode == 201) return true;
    return false;
  }

  static Future<bool> profileUpload (Map<String,dynamic> data) async {
    final response = await getIt.get<DioApiClient>().putRequest(ConstantsApiEndPoints.profileUpload, data);
    if (response?.statusCode == 200) return true;
    return false;
  }

  static Future<UserDetailsModel?> fetchingUserDetails (String id) async {
    UserDetailsModel? userDetailsModel;
    final response = await getIt.get<DioApiClient>().getRequest(ConstantsApiEndPoints.userDetails, id);
    if (response?.statusCode == 200){
      print("1212121212121212 : ${response!.data.toString()}");
      return UserDetailsModel.fromJson(response!.data['user']);
    }
    return userDetailsModel;
  }
}