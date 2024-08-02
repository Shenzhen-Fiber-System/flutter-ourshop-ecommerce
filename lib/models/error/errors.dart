
import 'package:ourshop_ecommerce/ui/pages/pages.dart';
import '../../main.dart';

class ErrorHandler extends DioException{
  final _context = navigatorKey.currentContext;
  ErrorHandler(DioException e) : super(
    requestOptions: e.requestOptions, 
    response: e.response, 
    type: e.type, 
    error: e.error
  ){
    handleError();
  }

  void handleError() {
    switch (response?.statusCode) {

      case 400:
        final error = RequestError.fromJson(response?.data);
        //TODO talk with backend developer to return the key for dynamic translations..
        ErrorToast(
          // title: AppLocalizations.of(_context!)!.user_exists,
          title: error.message,
          description: AppLocalizations.of(_context!)!.user_exist_description,
          style: ToastificationStyle.flatColored,
          foregroundColor: Colors.white,
          backgroundColor: Colors.red.shade500,
          icon: const Icon(Icons.error, color: Colors.white,),
        ).showToast(_context);
        break;
    //   case 401:
    //     ErrorToast(
    //       title: AppLocalizations.of(_context!)!.unauthorized,
    //       description: AppLocalizations.of(_context)!.unauthorized_description,
    //       style: ToastificationStyle.flatColored,
    //       foregroundColor: Colors.white,
    //       backgroundColor: Colors.red.shade500,
    //       icon: const Icon(Icons.error, color: Colors.white,),
    //     ).showToast(_context);
    //     break;
    //   case 403:
    //     ErrorToast(
    //       title: AppLocalizations.of(_context!)!.forbidden,
    //       description: AppLocalizations.of(_context)!.forbidden_description,
    //       style: ToastificationStyle.flatColored,
    //       foregroundColor: Colors.white,
    //       backgroundColor: Colors.red.shade500,
    //       icon: const Icon(Icons.error, color: Colors.white,),
    //     ).showToast(_context);
    //     break;
    //   case 404:
    //     ErrorToast(
    //       title: AppLocalizations.of(_context!)!.not_found,
    //       description: AppLocalizations.of(_context)!.not_found_description,
    //       style: ToastificationStyle.flatColored,
    //       foregroundColor: Colors.white,
    //       backgroundColor: Colors.red.shade500,
    //       icon: const Icon(Icons.error, color: Colors.white,),
    //     ).showToast(_context);
    //     break;
    //   case 500:
    //     ErrorToast(
    //       title: AppLocalizations.of(_context!)!.server_error,
    //       description: AppLocalizations.of(_context)!.server_error_description,
    //       style: ToastificationStyle.flatColored,
    //       foregroundColor: Colors.white,
    //       backgroundColor: Colors.red.shade500,
    //       icon: const Icon(Icons.error, color: Colors.white,),
    //     ).showToast(_context);
    //     break;
    }
  }


}


class RequestError {
    bool success;
    String message;
    dynamic data;

    RequestError({
        required this.success,
        required this.message,
        required this.data,
    });

    factory RequestError.fromJson(Map<String, dynamic> json) => RequestError(
        success: json["success"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
    };
}