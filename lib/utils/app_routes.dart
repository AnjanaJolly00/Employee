import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/add_employee_screen.dart';
import '../screens/employee_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  var navigatorKey = GlobalKey<NavigatorState>();

  CupertinoPageRoute invalidRoute(String? name) {
    return CupertinoPageRoute(
      settings: RouteSettings(name: name),
      builder: (_) => Scaffold(
        body: Center(
          key: const ValueKey('invalid_screen'),
          child: Text('No route defined for $name'),
        ),
      ),
    );
  }

  Route<dynamic> obtainRoute(RouteSettings setting) {
    switch (setting.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(
          settings: setting,
          builder: (_) => const LoginScreen(),
        );

      case EmployeeScreen.routeName:
        return MaterialPageRoute(
            settings: setting, builder: (_) => const EmployeeScreen());

      case AddEmployeeScreen.routeName:
        return MaterialPageRoute(
          settings: setting,
          builder: (_) => const AddEmployeeScreen(),
        );

      default:
        return invalidRoute(setting.name);
    }
  }
}
