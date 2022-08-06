import 'package:bot_toast/bot_toast.dart';
import 'package:employee_details/cubit/main_cubit.dart';
import 'package:employee_details/screens/add_employee_screen.dart';
import 'package:employee_details/utils/app_injector.dart';
import 'package:employee_details/utils/app_loader.dart';
import 'package:employee_details/utils/app_routes.dart';
import 'package:employee_details/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_state.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);
  static const routeName = "/EmployeeScreen";

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  late MainCubit _cubit;
  AppLoader appLoader = AppLoader();
  bool isLoading = false;
  @override
  void initState() {
    _cubit = context.read<MainCubit>();
    _cubit.getEmployeeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppWidgets.themeColor,
          onPressed: () {
            AppInjector.resolve<AppRoutes>()
                .navigatorKey
                .currentState!
                .pushNamed(AddEmployeeScreen.routeName);
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: AppWidgets.backgroundWhite,
        appBar: AppBar(
          title: const Text('Employee Details'),
          backgroundColor: AppWidgets.themeColor,
        ),
        body: BlocListener<MainCubit, MainState>(listener: (context, state) {
          if (state is GetEmployeeLoadingState) {
            appLoader.show(context);
            return;
          } else if (state is GetEmployeeDetailsSuccessState) {
            isLoading = false;
            appLoader.hide(context);
          } else if (state is GetEmployeeDetailsFailureState) {
            appLoader.hide(context);
            BotToast.showText(text: state.toString());
          }
        }, child: BlocBuilder<MainCubit, MainState>(builder: (context, state) {
          return body();
        })));
  }

  Widget body() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  var item = _cubit.employeeDetails[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(item.avatar!),
                        title: Text('${item.firstName} ${item.lastName}'),
                        subtitle: Text(item.email!),
                      ),
                    ),
                  );
                },
                itemCount: _cubit.employeeDetails.length),
          ),
          const SizedBox(
            height: 30,
          ),
          _cubit.canLoadMore == false
              ? const SizedBox(
                  height: 0,
                )
              : isLoading
                  ? const CircularProgressIndicator(
                      color: AppWidgets.themeColor,
                    )
                  : AppWidgets.elevatedButton(
                      buttonName: 'Load More',
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        _cubit.getEmployeeDetails(loadMore: true);
                      },
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 20,
                      fontSize: 18,
                      textColor: AppWidgets.textColor,
                    )
        ],
      ),
    );
  }

  @override
  void dispose() {
    appLoader.hide(context);
    super.dispose();
  }
}
