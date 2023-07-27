import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskhub/common/list_of_provider.dart';
import 'package:taskhub/common/local_storage.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/theme_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/login_page.dart';
import 'package:taskhub/features/presentation/pages/home_page.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/firebase/push_notification/push_notification.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'features/presentation/pages/authentication_pages/sign_up_page_for_google_phone.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  setup();

  //below code for disable landscape mode in mobile...
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //below code for firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await getIt.get<InternetCheckingService>().internetConnectionMonitoring();

  PushNotification.init();
  // PushNotification.getToken().then((value) => LocalStorage.storeFCMToken(fcmToken: value!));

  runApp(MultiProvider(providers: ListOfAppProvider.listsProvider, child: const InteractiaApp()));
}

class InteractiaApp extends StatefulWidget {
  const InteractiaApp({Key? key}) : super(key: key);

  @override
  State<InteractiaApp> createState() => _InteractiaAppState();
}

class _InteractiaAppState extends State<InteractiaApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async{
    final provider = Provider.of<InternetCheckingService>(context,listen: false);
    if(provider.isConnected){
      await Future.delayed(const Duration(milliseconds: 200),() => FlutterNativeSplash.remove());
    }else{
      AppDialog.noInternetDialog();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {

      return GetMaterialApp(
        title: AppConstantsText.appName,
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.appThemeMode,
        darkTheme: themeProvider.darkTheme,
        theme: themeProvider.lightTheme,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        home: FirebaseAuth.instance.currentUser?.uid != null ? HomePage() : LoginPage(),
        // home: SignUpPageForGooglePhoneLoginMethod(),
      );
    },);
  }
}
