

import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class ProductResponse extends Equatable {
    final bool success;
    final String message;
    final List<Product> data;

    const ProductResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
    
    @override
    List<Object?> get props => [
      success, 
      message, 
      data,
    ];
}

class Product extends Equatable {
    final String id;
    final String name;
    final String keyValue;
    final String? productGroupId;
    final String? companyId;
    final dynamic subCategoryId;
    final String? categoryId;
    final String? categoryName;
    final String modelNumber;
    final String? productTypeId;
    final String brandName;
    final String? unitMeasurementId;
    final int? fboPriceStart;
    final int? fboPriceEnd;
    final int? moqUnit;
    final int? stock;
    final double? packageLength;
    final double? packageWidth;
    final double? packageHeight;
    final double? packageWeight;
    final double? unitPrice;
    final List<Certification> specifications;
    final List<Certification> details;
    final List<Certification> certifications;
    final String? productStatus;
    final List<ProductPhotosVideos> productPhotos;
    final List<ProductPhotosVideos> productVideos;
    final dynamic mainPhotoUrl;
    final dynamic mainVideoUrl;

    const Product({
        required this.id,
        required this.name,
        required this.keyValue,
        required this.productGroupId,
        required this.companyId,
        required this.subCategoryId,
        required this.categoryId,
        required this.categoryName,
        required this.modelNumber,
        required this.productTypeId,
        required this.brandName,
        required this.unitMeasurementId,
        required this.fboPriceStart,
        required this.fboPriceEnd,
        required this.moqUnit,
        required this.stock,
        required this.packageLength,
        required this.packageWidth,
        required this.packageHeight,
        required this.packageWeight,
        required this.unitPrice,
        required this.specifications,
        required this.details,
        required this.certifications,
        required this.productStatus,
        required this.productPhotos,
        required this.productVideos,
        required this.mainPhotoUrl,
        required this.mainVideoUrl,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        keyValue: json["keyValue"],
        productGroupId: json["productGroupId"],
        companyId: json["companyId"],
        subCategoryId: json["subCategoryId"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        modelNumber: json["modelNumber"],
        productTypeId: json["productTypeId"],
        brandName: json["brandName"],
        unitMeasurementId: json["unitMeasurementId"],
        fboPriceStart: json["fboPriceStart"],
        fboPriceEnd: json["fboPriceEnd"],
        moqUnit: json["moqUnit"],
        stock: json["stock"],
        packageLength: json["packageLength"]?.toDouble(),
        packageWidth: json["packageWidth"]?.toDouble(),
        packageHeight: json["packageHeight"]?.toDouble(),
        packageWeight: json["packageWeight"]?.toDouble(),
        unitPrice: json["unitPrice"]?.toDouble(),
        specifications: List<Certification>.from(json["specifications"].map((x) => Certification.fromJson(x))),
        details: List<Certification>.from(json["details"].map((x) => Certification.fromJson(x))),
        certifications: List<Certification>.from(json["certifications"].map((x) => Certification.fromJson(x))),
        productStatus: json["productStatus"],
        productPhotos: List<ProductPhotosVideos>.from(json["productPhotos"].map((x) => ProductPhotosVideos.fromJson(x))),
        productVideos: List<ProductPhotosVideos>.from(json["productVideos"].map((x) => ProductPhotosVideos.fromJson(x))),
        mainPhotoUrl: json["mainPhotoUrl"],
        mainVideoUrl: json["mainVideoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "keyValue": keyValue,
        "productGroupId": productGroupId,
        "companyId": companyId,
        "subCategoryId": subCategoryId,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "modelNumber": modelNumber,
        "productTypeId": productTypeId,
        "brandName": brandName,
        "unitMeasurementId": unitMeasurementId,
        "fboPriceStart": fboPriceStart,
        "fboPriceEnd": fboPriceEnd,
        "moqUnit": moqUnit,
        "stock": stock,
        "packageLength": packageLength,
        "packageWidth": packageWidth,
        "packageHeight": packageHeight,
        "packageWeight": packageWeight,
        "unitPrice": unitPrice,
        "specifications": List<dynamic>.from(specifications.map((x) => x.toJson())),
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "certifications": List<dynamic>.from(certifications.map((x) => x.toJson())),
        "productStatus": productStatus,
        "productPhotos": List<dynamic>.from(productPhotos.map((x) => x.toJson())),
        "productVideos": List<dynamic>.from(productVideos.map((x) => x.toJson())),
        "mainPhotoUrl": mainPhotoUrl,
        "mainVideoUrl": mainVideoUrl,
    };
    
    @override
    List<Object?> get props => [
      id, 
      name, 
      keyValue, 
      productGroupId, 
      companyId, 
      subCategoryId, 
      categoryId, 
      categoryName, 
      modelNumber, 
      productTypeId, 
      brandName, 
      unitMeasurementId, 
      fboPriceStart, 
      fboPriceEnd, 
      moqUnit, 
      stock, 
      packageLength, 
      packageWidth, 
      packageHeight, 
      packageWeight, 
      unitPrice, 
      specifications, 
      details, 
      certifications, 
      productStatus, 
      productPhotos, 
      productVideos, 
      mainPhotoUrl, 
      mainVideoUrl, 
    ];
}

class Certification extends Equatable {
    final String id;
    final String name;
    final String? certificationNumber;
    final String productId;
    final String? description;

    const Certification({
        required this.id,
        required this.name,
        this.certificationNumber,
        required this.productId,
        this.description,
    });

    factory Certification.fromJson(Map<String, dynamic> json) => Certification(
        id: json["id"],
        name: json["name"],
        certificationNumber: json["certificationNumber"],
        productId: json["productId"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "certificationNumber": certificationNumber,
        "productId": productId,
        "description": description,
    };
    
      @override
      List<Object?> get props => [
        id, 
        name, 
        certificationNumber, 
        productId, 
        description,
      ];
}

class ProductPhotosVideos extends Equatable {
    final String id;
    final String productId;
    final ProductAsset? photo;
    final int importanceOrder;
    final ProductAsset? video;

    const ProductPhotosVideos({
        required this.id,
        required this.productId,
        this.photo,
        required this.importanceOrder,
        this.video,
    });

    factory ProductPhotosVideos.fromJson(Map<String, dynamic> json) => ProductPhotosVideos(
        id: json["id"],
        productId: json["productId"],
        photo: json["photo"] == null ? null : ProductAsset.fromJson(json["photo"]),
        importanceOrder: json["importanceOrder"],
        video: json["video"] == null ? null : ProductAsset.fromJson(json["video"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "photo": photo?.toJson(),
        "importanceOrder": importanceOrder,
        "video": video?.toJson(),
    };
    
      @override
      List<Object?> get props => [
        id, 
        productId, 
        photo, 
        importanceOrder, 
        video,
      ];
}

class ProductAsset extends Equatable {
    final String id;
    final String name;
    final String url;
    final int? importanceOrder;

    const ProductAsset({
        required this.id,
        required this.name,
        required this.url,
        required this.importanceOrder,
    });

    factory ProductAsset.fromJson(Map<String, dynamic> json) => ProductAsset(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        importanceOrder: json["importanceOrder"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "importanceOrder": importanceOrder,
    };
    
      @override
      List<Object?> get props => [
        id, 
        name, 
        url, 
        importanceOrder,
      ];
}