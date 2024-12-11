import 'package:appdid_assignment/screens/home_screen.dart';
import 'package:appdid_assignment/screens/login_screen.dart';
import 'package:appdid_assignment/screens/registration_screen.dart';
import 'package:get/route_manager.dart';

class Routes {
  Routes._();

  static const initialRoute = '/login';

  static List routes = [
    GetPageRoute(
      routeName: '/login',
      page: () => const LoginScreen(),
    ),
    GetPageRoute(
      routeName: '/registration',
      page: () => const RegistrationScreen(),
    ),
    GetPageRoute(
      routeName: '/home',
      page: () => const HomeScreen(),
    ),
  ];
}
