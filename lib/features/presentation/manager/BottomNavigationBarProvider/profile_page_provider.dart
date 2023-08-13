import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskhub/features/domain/entities/UserDetailsModel.dart';
import 'package:taskhub/features/domain/use_cases/user_register_use_case.dart';

import '../../../../locator.dart';

class ProfilePageProvider with ChangeNotifier {
  UserDetailsModel? userDetail;
  StreamController<UserDetailsModel> streamController = StreamController<UserDetailsModel>();

  loadUserDetailNotifier(String uid) async{
    userDetail = await getIt.get<UserRegisterUseCase>().fetchingUserDetails(FirebaseAuth.instance.currentUser!.uid);
    streamController.sink.add(userDetail!);
    notifyListeners();
  }
}