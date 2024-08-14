import '../../../ui/pages/pages.dart';

class CategoryService{

  final Dio dio;

  CategoryService({required this.dio});

  Future<dynamic> getCategories() async {
    try {
      final response = await dio.get('/categories');
      final categoryResponse = CategoryResponse.fromJson(response.data);
      return categoryResponse.data;
    } on DioException catch (e) {
      ErrorHandler(e);
    }
  }
}