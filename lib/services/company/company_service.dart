


import 'dart:developer';

import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class CompanyService {
  final Dio dio;
  CompanyService({required this.dio});

    Future<dynamic> getCompanies() async {
      try {
        final response = await dio.get('/companies');
        final companies = CompanyResponse.fromJson(response.data);
        return companies.data;
      } on DioException catch (e) {
        log('${e.response?.data}');
        ErrorHandler(e);
      }
    }

    Future<dynamic> getCompanyById(String id) async {
      try {
        final response = await dio.get('/companies');
        final Company company = Company.fromJson(response.data);
        return company;
      } on DioException catch (e) {
        log('${e.response?.data}');
        ErrorHandler(e);
      }
    }
  }