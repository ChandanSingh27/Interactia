import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/internet_checking.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/manager/theme_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/login_page.dart';
import 'package:taskhub/firebase/push_notification/push_notifiaction.dart';
import 'package:taskhub/locator.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  ], child: const TaskHubApp()));
}

class TaskHubApp extends StatelessWidget {
  const TaskHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("=====>build");
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {

      return MaterialApp(
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
