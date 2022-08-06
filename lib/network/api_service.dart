import 'package:dio/dio.dart';

class ApiService {
  final client = Dio();

  Future login({String? email, String? passWord}) async {
    Map<String, String> data = {
      "email": email!,
      "password": passWord!,
    };
    try {
      final response =
          await client.post('https://reqres.in/api/login', data: data);

      return [true, response.data];
    } on DioError catch (e) {
      return [false, e.response!.data];
    } catch (e) {
      return [false, e.toString()];
    }
  }

  Future getEmployeeDetails() async {
    try {
      final response = await client
          .getUri(Uri.parse('https://reqres.in/api/users?per_page=12'));

      return [true, response.data];
    } on DioError catch (e) {
      return [false, e.response!.data];
    } catch (e) {
      return [false, e.toString()];
    }
  }

  Future addEmployee({String? name, String? job}) async {
    Map<String, String> data = {"name": name!, "job": job!};
    try {
      final response =
          await client.post('https://reqres.in/api/users', data: data);
      return [true, response.data];
    } on DioError catch (e) {
      return [false, e.response!.data];
    } catch (e) {
      return [false, e.toString()];
    }
  }
}
