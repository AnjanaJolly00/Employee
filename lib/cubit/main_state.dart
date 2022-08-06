import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {}

class InitialState extends MainState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends MainState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends MainState {
  @override
  List<Object?> get props => [];
}

class LoginFailureState extends MainState {
  final String errorMsg;
  LoginFailureState({this.errorMsg = " "});
  @override
  List<Object?> get props => [errorMsg];
}

class GetEmployeeLoadingState extends MainState {
  @override
  List<Object?> get props => [];
}

class GetEmployeeDetailsSuccessState extends MainState {
  @override
  List<Object?> get props => [];
}

class GetEmployeeDetailsFailureState extends MainState {
  final String? errorMsg;
  GetEmployeeDetailsFailureState({this.errorMsg = " "});
  @override
  List<Object?> get props => [errorMsg];
}

class AddEmployeeLoadingState extends MainState {
  @override
  List<Object?> get props => [];
}

class AddEmployeeSuccessState extends MainState {
  @override
  List<Object?> get props => [];
}

class AddEmployeeFailureState extends MainState {
  final String? errorMsg;
  AddEmployeeFailureState({this.errorMsg = ""});
  @override
  List<Object?> get props => [errorMsg];
}
