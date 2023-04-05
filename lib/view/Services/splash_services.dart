import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:iiui_transport_app/view/Services/session_manager.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.homeusedScreen));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.loginScreen));
    }
  }
}
