import 'package:bot_toast/bot_toast.dart';
import 'package:employee_details/screens/login_screen.dart';
import 'package:employee_details/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/main_cubit.dart';
import 'utils/app_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInjector.setUp();
  runApp(
    BlocProvider(
      create: (_) => MainCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee Details',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        navigatorKey: AppInjector.resolve<AppRoutes>().navigatorKey,
        onGenerateRoute: AppInjector.resolve<AppRoutes>().obtainRoute,
        initialRoute: LoginScreen.routeName,
        theme: ThemeData(primarySwatch: Colors.blue));
  }
}
