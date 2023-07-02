import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/manager/theme_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/login_page.dart';
import 'package:taskhub/features/presentation/widgets/custom_dialog/app_dialogs.dart';
import 'package:taskhub/firebase/push_notification/push_notification.dart';
import 'package:taskhub/locator.dart';
import 'package:taskhub/utility/constants_text.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  setup();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getIt.get<InternetCheckingService>().internetConnectionMonitoring();

  PushNotification.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginPageProvider(),
    ),
    ChangeNotifierProvider(create: (context) => ThemeProvider(),),
    ChangeNotifierProvider.value(value: getIt.get<InternetCheckingService>()),
  ], child: const InteractiaApp()));
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
      await Future.delayed(const Duration(seconds: 2),() => FlutterNativeSplash.remove());
    }else{
      AppDialog.noInternetDialog();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {

      return MaterialApp(
        title: AppConstantsText.appName,
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.appThemeMode,
        darkTheme: themeProvider.darkTheme,
        theme: themeProvider.lightTheme,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        home: const LoginPage(),
      );
    },);
  }
}
