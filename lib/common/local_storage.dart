import 'package:shared_preferences/shared_preferences.dart';

import '../utility/constants_text.dart';

class LocalStorage {

  static void storeUserDetails({required String id,required String name,required String email,required String username}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(SharePreferenceConstantText.id, id);
    await preferences.setString(SharePreferenceConstantText.name, name);
    await preferences.setString(SharePreferenceConstantText.email, email);
    await preferences.setString(SharePreferenceConstantText.username, username);
  }
  static void setImageUrl({required String imageUrl}) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(SharePreferenceConstantText.imageUrl, imageUrl);
  }

  static void removeImageUrl() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(SharePreferenceConstantText.imageUrl);
  }

  static void removeUserDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  static void storeFCMToken({required String fcmToken}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(SharePreferenceConstantText.fcmToken, fcmToken);
  }

  static Future<String?> getKeyValue({required String key}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }


}