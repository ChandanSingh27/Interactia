

import 'package:get_it/get_it.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/firebase/authentication/firebase_authentication.dart';

GetIt getIt = GetIt.instance;

void setup(){
  //providers
  getIt.registerLazySingleton<InternetCheckingService>(() => InternetCheckingService());
  getIt.registerLazySingleton<LoginPageProvider>(() => LoginPageProvider());

  //firebase Authentication
  getIt.registerLazySingleton<FirebaseAuthentication>(() => FirebaseAuthentication());
}