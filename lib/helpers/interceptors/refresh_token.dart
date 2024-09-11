import 'dart:async';
import 'dart:developer';

import '../../ui/pages/pages.dart';

class RefreshTokenInterceptor extends Interceptor {
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = locator<Preferences>().preferences['token'];
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    log('Error interceptor: ${err.response?.data}');
    if (err.response?.statusCode == 401 && err.response?.data['message'] == 'Unauthorized') {
      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshCompleter = Completer<void>();

        try {
          final newTokens = await _refreshToken();
          if (newTokens != null) {
            locator<Preferences>().saveData('token', newTokens['accessToken']!);
            locator<Preferences>().saveData('refreshToken', newTokens['refreshToken']!);
            _refreshCompleter?.complete();
          } else {
            _refreshCompleter?.completeError('Failed to refresh token');
          }
        } catch (e) {
          _refreshCompleter?.completeError(e);
        } finally {
          _isRefreshing = false;
        }
      }

      await _refreshCompleter?.future;

      if (_refreshCompleter?.isCompleted == true) {
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer ${locator<Preferences>().preferences['token']}';

        try {
          final response = await locator<AuthService>().dio.request(
            options.path,
            options: Options(
              method: options.method,
              headers: options.headers,
            ),
            data: options.data,
            queryParameters: options.queryParameters,
          );

          return handler.resolve(response);
        } catch (e) {
          return handler.reject(DioException(requestOptions: options, error: 'Retry failed: $e'));
        }
      } else {
        return handler.reject(err);
      }
    } else {
      return handler.next(err);
    }
  }

  Future<Map<String, String>?> _refreshToken() async {
    final refreshToken = locator<Preferences>().preferences['refreshToken'];
    if (refreshToken != null) {
      try {
        final newTokens = await locator<AuthService>().refreshToken(refreshToken);
        if (newTokens != null) {
          return newTokens;
        }
      } catch (e) {
        log('Refresh token error: $e');
      }
    }
    return null;
  }
}
