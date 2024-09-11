import 'dart:developer';
import '../../../ui/pages/pages.dart';

class AuthService{

  final Dio dio;

  AuthService({required this.dio});

  Future<dynamic> login(Auth data) async {
    try {
      final response = await dio.post('/auth/login', data: data.login());
      final auth = Authentication.fromJson(response.data);
      locator<Preferences>().saveData('token', auth.data.token);
      locator<Preferences>().saveData('refreshToken', auth.data.refreshToken);
      final LoggedUser loggedUser = LoggedUser.fromJson(auth.data.getTokenPayload);
      return loggedUser;
    } on DioException catch (e) {
      // log('AuthService -> : ${e.response?.data}');
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


  Future<Map<String, String>?> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '/auth/refresh-token', 
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'})
      );

      log('refreshToken response: ${response.data}');
      
      final newToken = response.data['accessToken'];
      final newRefreshToken = response.data['refreshToken'];

      // Log para ver el nuevo token
      log('Nuevo token: $newToken');

      return {
        'accessToken': newToken,
        'refreshToken': newRefreshToken,
      };
    } on DioException catch (e) {
      log('refreshToken exception: ${e.response?.data}');
      return null; // Asegúrate de devolver null si falla
    }
  }


}