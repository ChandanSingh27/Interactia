import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/signup_provider.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:uuid/uuid.dart';

class FirebaseUploadFiles {

  static Future<String> uploadFile(BuildContext context,File file) async{
    UploadTask uploadTask = FirebaseStorage.instance.ref().child("UserProfileImage").child(const Uuid().v1().toString()).putFile(file);
    AppDialog.fileUploaderDialog();
    StreamSubscription streamSubscription =  uploadTask.snapshotEvents.listen((event) {
      double percentage = (event.bytesTransferred/event.totalBytes) * 100 ;
      if(percentage.floor() == 100) SmartDialog.dismiss();
      Provider.of<SignUpProvider>(context,listen: false).updateFileUploadPercentage(percentage.floor());
    });
    TaskSnapshot snapshot = await uploadTask;
    streamSubscription.cancel();
    return await snapshot.ref.getDownloadURL();
  }
}