import 'dart:developer';
import '../../../ui/pages/pages.dart';

class AuthService{

  final Dio dio;

  AuthService({required this.dio});

  Future<dynamic> login(Auth data) async {
    try {
      final response = await dio.post('/auth/login', data: data.login());
      final auth = Authentication.fromJson(response.data);
      locator<Preferences>().saveData('token',auth.data.token);
      final LoggedUser loggedUser = LoggedUser.fromJson(auth.data.getTokenPayload);
      return loggedUser;
    } on DioException catch (e) {
      log('AuthService -> : ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> register(NewUser data) async {
    try {
      final response = await dio.post('/auth/register', data: data.newUserToJson());
      final user = UserResponse.fromJson(response.data);
      return user.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }


}