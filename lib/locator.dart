

import 'package:get_it/get_it.dart';
import 'package:taskhub/features/data/repositories/user_repo_impl.dart';
import 'package:taskhub/features/domain/repositories/user_repo.dart';
import 'package:taskhub/features/domain/use_cases/user_register_use_case.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';

import 'api_calls/dio_clients.dart';

GetIt getIt = GetIt.instance;

void setup(){
  //providers
  getIt.registerLazySingleton<InternetCheckingService>(() => InternetCheckingService());
  getIt.registerLazySingleton<LoginPageProvider>(() => LoginPageProvider());

  //firebase Authentication
  getIt.registerLazySingleton<FirebaseAuthentication>(() => FirebaseAuthentication());

  getIt.registerLazySingleton<DioApiClient>(() => DioApiClient());
  getIt.registerLazySingleton<UserRepo>(() => UserRepoImpl());


  //use case locator
  getIt.registerLazySingleton<UserRegisterUseCase>(() => UserRegisterUseCase());
}