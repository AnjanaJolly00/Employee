import 'package:dio/dio.dart';
import 'package:employee_details/data/get_employee_api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/api_service.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit([MainState? initialState]) : super(initialState ?? InitialState());
  final client = Dio();
  final ApiService _apiService = ApiService();

  List<Employee> employeeDetails = [];

  Future login({String? email, String? password}) async {
    emit(LoginLoadingState());
    var apiResponse = await _apiService.login(email: email, passWord: password);
    if (apiResponse[0] == true) {
      emit(LoginSuccessState());
    } else {
      emit(LoginFailureState(errorMsg: apiResponse[1]['error']));
    }
  }

  Future getEmployeeDetails({isLoading = false}) async {
    emit(GetEmployeeLoadingState());
    var apiresponse = await _apiService.getEmployeeDetails();
    if (apiresponse[0] == true) {
      employeeDetails = EmployeeApiResponse.fromMap(apiresponse[1]).employee!;
      emit(GetEmployeeDetailsSuccessState());
    } else {
      emit(GetEmployeeDetailsFailureState(errorMsg: apiresponse[1]['error']));
    }
  }

  Future addEmployee({String? name, String? job}) async {
    emit(AddEmployeeLoadingState());
    var apiResponse = await _apiService.addEmployee(name: name, job: job);

    if (apiResponse[0] == true) {
      emit(AddEmployeeSuccessState());
    } else {
      emit(AddEmployeeFailureState(errorMsg: apiResponse[1]['error']));
    }
  }
}
