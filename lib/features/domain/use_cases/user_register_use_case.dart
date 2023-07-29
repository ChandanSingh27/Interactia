
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/locator.dart';
import '../repositories/user_repo.dart';

class UserRegisterUseCase {
  Future<bool?> userAlreadyRegisterOrNotUseCase(String uid) => getIt.get<UserRepo>().userAlreadyRegister(uid);
  Future<bool?> createNewUserUseCase(Map<String,dynamic> model) => getIt.get<UserRepo>().userRegister(model);
  Future<bool?> uploadUserProfileLinkUseCase(Map<String,dynamic> data) => getIt.get<UserRepo>().userProfileLinkUpload(data);
  Future<UserDetailsModel?> fetchingUserDetails(String id) => getIt.get<UserRepo>().fetchUserDetails(id);
}