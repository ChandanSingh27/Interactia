
import 'package:taskhub/locator.dart';
import '../repositories/user_repo.dart';

class UserRegisterUseCase {
  Future<bool?> call(String uid) => getIt.get<UserRepo>().userAlreadyRegister(uid);
  Future<bool?> callUserRegister(Map<String,dynamic> model) => getIt.get<UserRepo>().userRegister(model);
  Future<bool?> callUserUploadProfileLink(Map<String,dynamic> data) => getIt.get<UserRepo>().userProfileLinkUpload(data);
}