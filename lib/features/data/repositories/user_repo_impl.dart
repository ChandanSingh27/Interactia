import 'package:flutter/foundation.dart';
import 'package:taskhub/features/data/data_sources/fetch_user_data.dart';
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/features/domain/repositories/user_repo.dart';

class UserRepoImpl extends UserRepo{
  @override
  Future<bool?> userAlreadyRegister(String uid) async{
    try{
      return FetchUserData.userAlreadyRegisterOrNot(uid);
    }catch(error) {
      if(kDebugMode) print("userAlreadyRegister error : ${error.toString()}");
    }
  }

  @override
  Future<bool?> userRegister(Map<String,dynamic> model) async{
    try{
        return FetchUserData.createNewUser(model);
    }catch(error) {
      if(kDebugMode) print("userRegister error : ${error.toString()}");
    }
  }

  @override
  Future<bool?> userProfileLinkUpload(Map<String, dynamic> data) async{
    return FetchUserData.profileUpload(data);
  }

  @override
  Future<UserDetailsModel?> fetchUserDetails(String id) {
      return FetchUserData.fetchingUserDetails(id);
  }

}