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

  Future<dynamic> getReviewByProduct(String productId) async {
    try {
      final response = await dio.get('/product-reviews/product/$productId');
      final reviews = ReviewsResponse.fromJson(response.data);
      return reviews.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> filteredAdminProducts(Map<String, dynamic> filteredParamenters) async {
    try {
      final response = await dio.post('/products/filtered-page', data: filteredParamenters);
      final filteredProducts = FilteredResponse<FilteredProducts>.fromJson(response.data, (json) => FilteredProducts.fromJson(json));
      return filteredProducts.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> deleteAdminProductById(String productId) async {
    try {
      await dio.delete('/products/$productId');
      SuccessToast(
        title: translations!.product_deleted,
        style: ToastificationStyle.flatColored,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade500,
      )
      .showToast(AppRoutes.globalContext!);
      return true;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> filteredProducts(Map<String, dynamic> filteredParamenters) async {
    try {
      final response = await dio.post('/products/filtered-page', data: filteredParamenters);
      final filteredProducts = FilteredResponse<FilteredProducts>.fromJson(response.data, (json) => FilteredProducts.fromJson(json));
      return filteredProducts.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }


}