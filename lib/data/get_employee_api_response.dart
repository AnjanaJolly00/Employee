import 'dart:convert';

class EmployeeApiResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Employee>? employee;
  EmployeeApiResponse(
      {required this.employee,
      required this.page,
      required this.perPage,
      required this.total,
      required this.totalPages});

  factory EmployeeApiResponse.fromJson(String str) =>
      EmployeeApiResponse.fromMap(jsonDecode(str));

  factory EmployeeApiResponse.fromMap(Map<String, dynamic> json) =>
      EmployeeApiResponse(
          page: json['page'] == null ? null : json['page'],
          perPage: json['per_page'] == null ? null : json['per_page'],
          total: json['total'] == null ? null : json['total'],
          totalPages: json['total_pages'] == null ? null : json['total_pages'],
          employee: json['data'] == null
              ? null
              : List<Employee>.from(
                  json["data"].map((x) => Employee.fromMap(x))));
}

class Employee {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  Employee(
      {required this.avatar,
      required this.email,
      required this.firstName,
      required this.id,
      required this.lastName});

  factory Employee.fromJson(String str) => Employee.fromMap(jsonDecode(str));

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
      avatar: json['avatar'] == null ? null : json['avatar'],
      email: json['email'] == null ? null : json['email'],
      firstName: json['first_name'] == null ? null : json['first_name'],
      id: json['id'] == null ? null : json['id'],
      lastName: json['last_name'] == null ? null : json['last_name']);
}
