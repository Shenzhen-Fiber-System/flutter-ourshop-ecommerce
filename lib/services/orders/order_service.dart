import 'package:ourshop_ecommerce/models/models.dart';

import '../../ui/pages/pages.dart';

class OrderService {

  final Dio dio;

  OrderService({required this.dio});


  Future<dynamic> getFilteredAdminOrders(Map<String, dynamic> filteredParameters) async {
    try {
      final response = await dio.post('/orders/filtered-page', data: filteredParameters);
      final filteredOrders = FilteredResponse<FilteredOrders>.fromJson(response.data,(json) => FilteredOrders.fromJson(json));
      return filteredOrders.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> getOrderbyId(String id) async {
    try {
      final response = await dio.get('/orders/$id');
      final data = OrderResponse.fromJson(response.data);
      return data.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

}