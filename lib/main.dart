import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskhub/features/presentation/manager/login_page_provider.dart';
import 'package:taskhub/features/presentation/pages/authentication_pages/login_page.dart';
import 'package:taskhub/firebase/push_notification/push_notifiaction.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotification.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LoginPageProvider(),
    )
  ], child: const TaskHubApp()));
}

class TaskHubApp extends StatelessWidget {
  const TaskHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
      home: const LoginPage(),
    );
  }
}
