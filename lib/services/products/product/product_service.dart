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
    log('categoryId: $categoryId');
    try {
      final response = await dio.get('/products/by-category/$categoryId');
      final products = FilteredResponse<FilteredProduct>.fromJson(response.data, (json) => FilteredProduct.fromJson(json));
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
      log('url: ${dio.options.baseUrl}');
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
      // log('filteredParamenters: $filteredParamenters');
      final response = await dio.post('/products/filtered-page', data: filteredParamenters);
      final filteredProducts = FilteredResponse<FilteredProduct>.fromJson(response.data, (json) => FilteredProduct.fromJson(json));
      // log('filteredProducts: ${filteredProducts.data.content.length}');
      return filteredProducts.data;
    } on DioException catch (e) {
      log('error filteredProducts: ${e.response?.data}');
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

  Future<dynamic> updateCountryGroupById (String countryGroupId, Map<String,dynamic> body) async {
    try {
      final response = await dio.put('/country-groups/$countryGroupId', data: body);
      log('updateCountryGroupById: ${response.data}');
    } on DioException catch (e) {
      log('error updateCountryGroupById: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> getCountryGroupsByCompany(String companyId) async {
    try {
      final response = await dio.get('/country-groups/company');
      final countryGroups = CountryGroupResponse.fromJson(response.data);
      return countryGroups.data;
    } on DioException catch (e) {
      log('error getCountryGroupsByCompany: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> addNewCountryGroup(Map<String, dynamic> body) async {
    try {
      final response = await dio.post('/country-groups', data: body);
      if (response.data['success'] == true) {
        SuccessToast(
          title: locator<AppLocalizations>().country_group_added,
          style: ToastificationStyle.flatColored,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green.shade500,
        ).showToast(AppRoutes.globalContext!);

        return true;

      }
    } on DioException catch (e) {
      log('error addNewCountryGroup: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> getShippingRates(Map<String, dynamic> filteredParams) async {
    try {
      final response = await dio.post('/shipping-rates/filtered-page', data: filteredParams);
      final shippingRates = FilteredResponse<FilteredShippingRate>.fromJson(response.data, (json) => FilteredShippingRate.fromJson(json));
      return shippingRates.data;
    } on DioException catch (e) {
      log('error getShippingRates: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> addNewShippingRate(Map<String, dynamic> body) async {
    try {
      final response = await dio.post('/shipping-rates', data: body);
      if (response.data['success'] == true) {
        SuccessToast(
          title: locator<AppLocalizations>().shipping_rate_added,
          style: ToastificationStyle.flatColored,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green.shade500,
        ).showToast(AppRoutes.globalContext!);
      }
    } on DioException catch (e) {
      log('error addNewShippingRate: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> getFilteredOfferTypes(Map<String, dynamic> filteredParams) async {
    try {
      final response = await dio.post('/offer-types/filtered-page', data: filteredParams);
      final offerTypes = FilteredResponse<FilteredOfferTypes>.fromJson(response.data, (json) => FilteredOfferTypes.fromJson(json));
      return offerTypes.data;
    } on DioException catch (e) {
      log('error getFilteredOfferTypes: ${e.response?.data}');
      ErrorHandler(e);
    }
  }


  Future<dynamic> getSearchProductShippingRates(String query) async {
    try {
      final response = await dio.get('/products/search/$query');
      final searchProductShippingRates = ProductResponse.fromJson(response.data);
      return searchProductShippingRates.data;
    } on DioException catch (e) {
      log('DioException: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> calculateshippingRate(Map<String,dynamic> data) async {
    try {
      log('dio: ${dio.options.headers}');
      log('data: $data');
      final response = await dio.post('/shipping-rates/calculate', data: data );
      log('response: ${response.data}');

    } on DioException catch (e) {
      log('error calculateshipping: ${e.response?.data}');
      ErrorHandler(e);
    }
  }

  Future<dynamic> getProdutsOffers(Map<String,dynamic>filteredParams) async {
    try {
      final response = await dio.post('/offers/filtered-page', data: filteredParams);
      final productsOffers = FilteredResponse<FilteredOfferProduct>.fromJson(response.data, (json) => FilteredOfferProduct.fromMap(json)) ;
      return productsOffers.data;
    } on DioException catch (e) {
      log('error getProdutsOffers: ${e.response?.data}');
      ErrorHandler(e);
    }
  }
}


//TODO pasos

// - caluclar el costo de envio