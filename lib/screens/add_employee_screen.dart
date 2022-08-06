import 'package:bot_toast/bot_toast.dart';
import 'package:employee_details/cubit/main_cubit.dart';
import 'package:employee_details/utils/app_loader.dart';
import 'package:employee_details/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_state.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);
  static const routeName = "/AddEmployeeScreen";

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  late MainCubit _cubit;
  AppLoader loader = AppLoader();
  @override
  void initState() {
    _cubit = context.read<MainCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppWidgets.themeColor,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Add Employee'),
          backgroundColor: AppWidgets.themeColor,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocListener<MainCubit, MainState>(
              listener: (context, state) {
                if (state is AddEmployeeLoadingState) {
                  loader.show(context);
                  return;
                } else if (state is AddEmployeeSuccessState) {
                  loader.hide(context);
                  BotToast.showText(text: 'Added Successfully');
                } else if (state is AddEmployeeFailureState) {
                  loader.hide(context);
                  BotToast.showText(text: state.errorMsg!);
                }
              },
              child: body()),
        ));
  }

  Widget body() {
    return Column(
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
              nameField,
              const SizedBox(
                height: 20,
              ),
              jobField,
              //  loginButton(context),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<MainCubit, MainState>(builder: (context, state) {
                return addButton;
              })
            ],
          ),
        )
      ],
    );
  }

  Widget get nameField => AppWidgets.labelledTextField(
      label: 'Name',
      controller: nameController,
      onChanged: (value) {},
      keyboardType: TextInputType.emailAddress,
      maxLength: 10,
      hint: '',
      isObscureText: false);

  Widget get jobField => AppWidgets.labelledTextField(
      label: 'Job',
      controller: jobController,
      onChanged: (value) {},
      keyboardType: TextInputType.visiblePassword,
      maxLength: 10,
      hint: '',
      isObscureText: false);

  Widget get addButton => AppWidgets.elevatedButton(
      buttonName: 'Add Employee',
      fontSize: 18,
      width: double.infinity,
      height: 52,
      color: AppWidgets.themeColor,
      textColor: AppWidgets.backgroundWhite,
      onPressed: () {
        nameController.text.isEmpty
            ? BotToast.showText(text: "Name can't be empty")
            : jobController.text.isEmpty
                ? BotToast.showText(text: "Job can't be empty")
                : _cubit
                    .addEmployee(
                        name: nameController.text, job: jobController.text)
                    .then((value) =>
                        {nameController.clear(), jobController.clear()});
      });

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    super.dispose();
  }
}
