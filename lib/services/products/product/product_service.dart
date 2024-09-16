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
      final filteredProducts = FilteredResponse<FilteredProduct>.fromJson(response.data, (json) => FilteredProduct.fromJson(json));
      return filteredProducts.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> deleteAdminProductById(String productId) async {
    try {
      await dio.delete('/products/$productId');
      SuccessToast(
        title: locator<AppLocalizations>().product_deleted,
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
      final filteredProducts = FilteredResponse<FilteredProduct>.fromJson(response.data, (json) => FilteredProduct.fromJson(json));
      return filteredProducts.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> filteredCountriesGroup(Map<String, dynamic> filteredParams) async {
    try {
      final response = await dio.post('/country-groups/filtered-page', data: filteredParams);
      final countriesGroup = FilteredResponse<FilteredGroupCountries>.fromJson(response.data, (json) => FilteredGroupCountries.fromJson(json));
      return countriesGroup.data;
    } on DioException catch (e) {
      log('filteredCountriesGroup: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> getProductGroups() async {
    try {
      final response = await dio.get('/product-groups');      
      final productGroups = ProductGroupsResponse.fromJson(response.data);
      return productGroups.data;
    } on DioException catch (e) {
      log('error productGroups: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> getProductsType() async {
    try {
      final response = await dio.get('/product-types');
      final productTypes = ProductTypeResponse.fromJson(response.data);
      return productTypes.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> getUnitMeasurement() async {
    try {
      final response = await dio.get('/unit-measurements');
      final unitMeasurements = UnitMeasurementResponse.fromJson(response.data);
      return unitMeasurements.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }

  Future<dynamic> addNewProduct(FormData formData) async {
    try {
      final response = await dio.post('/products', data: formData, options: Options(contentType: 'multipart/form-data'));
      if (response.data['success'] == true) {
        SuccessToast(
          title: locator<AppLocalizations>().product_added,
          style: ToastificationStyle.flatColored,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green.shade500,
        )
        .showToast(AppRoutes.globalContext!);
      }
    } on DioException catch (e) {
      log('error addNewProduct: ${e.response?.data}');
      ErrorHandler(e);
    }
  }
}