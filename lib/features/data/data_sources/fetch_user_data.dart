
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskhub/api_calls/dio_clients.dart';
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_api_endpoints.dart';
import 'package:path_provider/path_provider.dart';

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
    String userFile = "userDetails.json";
    final tempDic = await getTemporaryDirectory();
    var file = File("${tempDic.path}/$userFile");
    if(file.existsSync()) {
      var json = file.readAsStringSync();
      return UserDetailsModel.fromJson(jsonDecode(json));
    }else{
      final response = await getIt.get<DioApiClient>().getRequest(ConstantsApiEndPoints.userDetails, id);
      if (response?.statusCode == 200){
        await file.writeAsString(jsonEncode(response!.data['user']).toString(),flush: true,mode: FileMode.write);
        return UserDetailsModel.fromJson(response!.data['user']);
      }
    }

    return userDetailsModel;
  }
}