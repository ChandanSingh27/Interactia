import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';

abstract class UserRepo {
  Future<bool?> userAlreadyRegister(String uid);
  Future<bool?> userRegister(Map<String,dynamic> model);
}