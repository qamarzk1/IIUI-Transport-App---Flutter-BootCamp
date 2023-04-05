import 'package:flutter/material.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:iiui_transport_app/view/Bus%20Details/bus_details.dart';
import 'package:iiui_transport_app/view/Card/card_screen.dart';
import 'package:iiui_transport_app/view/Contact/contact_screen.dart';
import 'package:iiui_transport_app/view/Foregot%20Password/forgot_password.dart';
import 'package:iiui_transport_app/view/HomeScreen/home_screen.dart';
import 'package:iiui_transport_app/view/HomeScreen/homeused_screen.dart';
import 'package:iiui_transport_app/view/Profile%20Screen/profile_screen.dart';
import 'package:iiui_transport_app/view/User%20List/userlist_screen.dart';
import 'package:iiui_transport_app/view/signup/sign_up_screen.dart';

import '../../view/login/login_screen.dart';
import '../../view/splash/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case RouteName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteName.homeusedScreen:
        return MaterialPageRoute(builder: (_) => const HomeUsedScreen());

      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileSceen());

      case RouteName.busdetailsScreen:
        return MaterialPageRoute(builder: (_) => const BusdetailsScreen());

      case RouteName.userlistScreen:
        return MaterialPageRoute(builder: (_) => const UserlistScreen());

      case RouteName.contactScreen:
        return MaterialPageRoute(builder: (_) => const ContactScreen());

      case RouteName.cardScreen:
        return MaterialPageRoute(builder: (_) => const CardScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
