
import '../entities/UserDetailsModel.dart';

abstract class UserRepo {
  Future<bool?> userAlreadyRegister(String uid);
  Future<bool?> userRegister(Map<String,dynamic> model);
  Future<bool?> userProfileLinkUpload(Map<String,dynamic> data);
  Future<UserDetailsModel?> fetchUserDetails(String id);
}