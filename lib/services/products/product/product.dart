import 'dart:developer';

import '../../../ui/pages/pages.dart';

class ProductService {

  final Dio dio;

  ProductService({required this.dio});

  Future<dynamic> getProducts() async {
    try {
      final response = await dio.get('/products', );
      final products = ProductResponse.fromJson(response.data);
      return products.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> getCategories() async {
    try {
      final response = await dio.get('/categories');
      final CategoryResponse categoryResponse = CategoryResponse.fromJson(response.data);
      return categoryResponse.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }


  Future<dynamic> getProductsByCategory(String categoryId) async {
    try {
      final response = await dio.get('/products/by-category/$categoryId');
      final products = ProductResponse.fromJson(response.data);
      return products.data;
    } on DioException catch (e) {
      log(e.response?.data);
      ErrorHandler(e);
    }
  }

  Future<List<Content>> filtered(String uuid) async {

    final Map<String, dynamic> body = {
      "uuids": [ {
          "fieldName":"category.id", 
          "value":uuid
        }
      ],
      "searchFields": [],
      "sortOrders": [],
      "page": 1,
      "pageSize": 250,
      "searchString": ""
    };
    try {
      final response = await  dio.post('/products/filtered-page', data: body);
      final FilterResponse products = FilterResponse.fromJson(response.data);
      return products.data.content;
    } on DioException catch (e) {
      ErrorHandler(e);
      return [];
    }
  }


}