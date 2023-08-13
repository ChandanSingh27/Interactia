import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:taskhub/features/presentation/manager/BottomNavigationBarProvider/profile_page_provider.dart';
import 'package:taskhub/features/presentation/manager/app_bottom_navigation_provider.dart';
import 'package:taskhub/features/presentation/manager/post_page_provider.dart';
import '../features/presentation/manager/internet_checking.dart';
import '../features/presentation/manager/login_page_provider.dart';
import '../features/presentation/manager/signup_provider.dart';
import '../features/presentation/manager/theme_provider.dart';
import '../locator.dart';

class ListOfAppProvider extends MultiProvider{
  ListOfAppProvider({super.key, required super.providers});

  static List<SingleChildWidget> listsProvider = [
    ChangeNotifierProvider(create: (context) => LoginPageProvider(),),
    ChangeNotifierProvider(create: (context) => ThemeProvider(),),
    ChangeNotifierProvider(create: (context) => SignUpProvider(),),
    ChangeNotifierProvider(create: (context) => AppBottomNavigationProvider(),),
    ChangeNotifierProvider(create: (context) => PostPageProvider(),),
    ChangeNotifierProvider(create: (context) => ProfilePageProvider(),),
    ChangeNotifierProvider.value(value: getIt.get<InternetCheckingService>()),
  ];


}