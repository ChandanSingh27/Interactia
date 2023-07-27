
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/locator.dart';
import '../repositories/user_repo.dart';

class UserRegisterUseCase {
  Future<bool?> call(String uid) => getIt.get<UserRepo>().userAlreadyRegister(uid);
  Future<bool?> callUserRegister(Map<String,dynamic> model) => getIt.get<UserRepo>().userRegister(model);
}