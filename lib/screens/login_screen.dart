import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:employee_details/screens/employee_screen.dart';
import 'package:employee_details/utils/app_injector.dart';
import 'package:employee_details/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/main_cubit.dart';
import '../cubit/main_state.dart';
import '../utils/app_loader.dart';
import '../widgets/app_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  AppLoader appLoader = AppLoader();
  bool showTick = false;
  bool _isObscure = true;
  bool _isValidEmail = false;
  late MainCubit cubit;

  @override
  void initState() {
    cubit = context.read<MainCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppWidgets.themeColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocListener<MainCubit, MainState>(
            listener: (context, state) {
              if (state is LoginLoadingState) {
                appLoader.show(context);
                return;
              } else if (state is LoginSuccessState) {
                appLoader.hide(context);
                AppInjector.resolve<AppRoutes>()
                    .navigatorKey
                    .currentState!
                    .pushNamedAndRemoveUntil(
                        EmployeeScreen.routeName, (route) => false);
              } else if (state is LoginFailureState) {
                appLoader.hide(context);
                BotToast.showText(text: state.errorMsg);
              }
            },
            child: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
              return body();
            }),
          ),
        ));
  }

  Widget body() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                emailField,
                const SizedBox(
                  height: 20,
                ),
                passwordField,
                //  loginButton(context),
                const SizedBox(
                  height: 30,
                ),
                loginButton
              ],
            ),
          )
        ],
      );

  Widget get emailField => AppWidgets.labelledTextField(
      label: 'Email Address',
      controller: emailTextEditingController,
      onChanged: (value) => {checkEmailField(), setState(() {})},
      keyboardType: TextInputType.emailAddress,
      maxLength: 10,
      hint: '',
      isObscureText: false);

  Widget get passwordField => AppWidgets.labelledTextField(
      label: 'Password',
      controller: passwordTextEditingController,
      onChanged: (value) => setState(() {}),
      keyboardType: TextInputType.visiblePassword,
      maxLength: 10,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            _isObscure = !_isObscure;
          });
        },
        icon: Icon(
          _isObscure
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppWidgets.textfieldLabel,
        ),
      ),
      hint: '',
      isObscureText: _isObscure);

  Widget get loginButton => AppWidgets.elevatedButton(
      buttonName: 'Login',
      fontSize: 18,
      width: double.infinity,
      height: 52,
      color: AppWidgets.themeColor,
      textColor: AppWidgets.backgroundWhite,
      onPressed: () {
        FocusScope.of(context).unfocus();
        !_isValidEmail
            ? BotToast.showText(text: 'Please enter a vald email address')
            : passwordTextEditingController.text.isEmpty
                ? BotToast.showText(text: "Password can't be empty")
                : cubit.login(
                    email: emailTextEditingController.text,
                    password: passwordTextEditingController.text);
      });

  Timer? _debounce;

  checkEmailField() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _isValidEmail = isValidEmail(emailTextEditingController.text);
        showTick = _isValidEmail;
      });
    });
  }

  bool isValidEmail(email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
}
