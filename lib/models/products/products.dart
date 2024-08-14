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
    final double? fboPriceStart;
    final double? fboPriceEnd;
    final dynamic moqUnit;
    final dynamic stock;
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


class FilterResponse extends Equatable {
    final bool success;
    final String message;
    final Data data;

    const FilterResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    FilterResponse copyWith({
        bool? success,
        String? message,
        Data? data,
    }) => 
        FilterResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory FilterResponse.fromJson(Map<String, dynamic> json) => FilterResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
    
    @override
    List<Object?> get props => [
      success, 
      message, 
      data,
    ];
}

class Data extends Equatable {
    final List<Content> content;
    final int totalElements;
    final int page;
    final int pageSize;
    final int totalPages;

    const Data({
        required this.content,
        required this.totalElements,
        required this.page,
        required this.pageSize,
        required this.totalPages,
    });

    Data copyWith({
        List<Content>? content,
        int? totalElements,
        int? page,
        int? pageSize,
        int? totalPages,
    }) => 
        Data(
            content: content ?? this.content,
            totalElements: totalElements ?? this.totalElements,
            page: page ?? this.page,
            pageSize: pageSize ?? this.pageSize,
            totalPages: totalPages ?? this.totalPages,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        totalElements: json["totalElements"],
        page: json["page"],
        pageSize: json["pageSize"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "totalElements": totalElements,
        "page": page,
        "pageSize": pageSize,
        "totalPages": totalPages,
    };
    
    @override
    List<Object?> get props => [
      content, 
      totalElements, 
      page, 
      pageSize, 
      totalPages,
    ];
}

class Content extends Equatable {
    final String id;
    final String name;
    final KeyValue? keyValue;
    final String? productGroupId;
    // final ProductGroupName productGroupName;
    final String? companyId;
    final String? companyName;
    final String? categoryId;
    final CategoryName? categoryName;
    final String? modelNumber;
    final String? productTypeId;
    final ProductTypeName? productTypeName;
    final BrandName? brandName;
    final String? unitMeasurementId;
    final UnitMeasurementName? unitMeasurementName;
    final double? fboPriceStart;
    final double? fboPriceEnd;
    final double? moqUnit;
    final double? unitPrice;
    final double? stock;
    final double? packageLength;
    final double? packageWidth;
    final double? packageHeight;
    final double? packageWeight;
    final dynamic productStatus;
    final String? mainPhotoUrl;
    final String? mainVideoUrl;

    const Content({
        required this.id,
        required this.name,
        this.keyValue,
        this.productGroupId,
        // required this.productGroupName,
        this.companyId,
        this.companyName,
        this.categoryId,
        this.categoryName,
        this.modelNumber,
        this.productTypeId,
        this.productTypeName,
        this.brandName,
        this.unitMeasurementId,
        this.unitMeasurementName,
        this.fboPriceStart,
        this.fboPriceEnd,
        this.moqUnit,
        this.unitPrice,
        this.stock,
        this.packageLength,
        this.packageWidth,
        this.packageHeight,
        this.packageWeight,
        this.productStatus,
        this.mainPhotoUrl,
        this.mainVideoUrl,
    });

    Content copyWith({
        String? id,
        String? name,
        KeyValue? keyValue,
        String? productGroupId,
        // ProductGroupName? productGroupName,
        String? companyId,
        String? companyName,
        String? categoryId,
        CategoryName? categoryName,
        String? modelNumber,
        String? productTypeId,
        ProductTypeName? productTypeName,
        BrandName? brandName,
        String? unitMeasurementId,
        UnitMeasurementName? unitMeasurementName,
        double? fboPriceStart,
        double? fboPriceEnd,
        double? moqUnit,
        double? unitPrice,
        double ? stock,
        double ? packageLength,
        double ? packageWidth,
        double ? packageHeight,
        double ? packageWeight,
        dynamic productStatus,
        String? mainPhotoUrl,
        String? mainVideoUrl,
    }) => 
        Content(
            id: id ?? this.id,
            name: name ?? this.name,
            keyValue: keyValue ?? this.keyValue,
            productGroupId: productGroupId ?? this.productGroupId,
            // productGroupName: productGroupName ?? this.productGroupName,
            companyId: companyId ?? this.companyId,
            companyName: companyName ?? this.companyName,
            categoryId: categoryId ?? this.categoryId,
            categoryName: categoryName ?? this.categoryName,
            modelNumber: modelNumber ?? this.modelNumber,
            productTypeId: productTypeId ?? this.productTypeId,
            productTypeName: productTypeName ?? this.productTypeName,
            brandName: brandName ?? this.brandName,
            unitMeasurementId: unitMeasurementId ?? this.unitMeasurementId,
            unitMeasurementName: unitMeasurementName ?? this.unitMeasurementName,
            fboPriceStart: fboPriceStart ?? this.fboPriceStart,
            fboPriceEnd: fboPriceEnd ?? this.fboPriceEnd,
            moqUnit: moqUnit ?? this.moqUnit,
            unitPrice: unitPrice ?? this.unitPrice,
            stock: stock ?? this.stock,
            packageLength: packageLength ?? this.packageLength,
            packageWidth: packageWidth ?? this.packageWidth,
            packageHeight: packageHeight ?? this.packageHeight,
            packageWeight: packageWeight ?? this.packageWeight,
            productStatus: productStatus ?? this.productStatus,
            mainPhotoUrl: mainPhotoUrl ?? this.mainPhotoUrl,
            mainVideoUrl: mainVideoUrl ?? this.mainVideoUrl,
        );

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        name: json["name"],
        keyValue: keyValueValues.map[json["keyValue"]],
        productGroupId: json["productGroupId"],
        // productGroupName: productGroupNameValues.map[json["productGroupName"]],
        companyId: json["companyId"],
        companyName: json["companyName"],
        categoryId: json["categoryId"],
        categoryName: categoryNameValues.map[json["categoryName"]],
        modelNumber: json["modelNumber"],
        productTypeId: json["productTypeId"],
        productTypeName: productTypeNameValues.map[json["productTypeName"]],
        brandName: brandNameValues.map[json["brandName"]],
        unitMeasurementId: json["unitMeasurementId"],
        unitMeasurementName: unitMeasurementNameValues.map[json["unitMeasurementName"]],
        fboPriceStart: json["fboPriceStart"],
        fboPriceEnd: json["fboPriceEnd"],
        moqUnit: json["moqUnit"],
        unitPrice: json["unitPrice"]?.toDouble(),
        stock: json["stock"],
        packageLength: json["packageLength"],
        packageWidth: json["packageWidth"],
        packageHeight: json["packageHeight"],
        packageWeight: json["packageWeight"],
        productStatus: json["productStatus"],
        mainPhotoUrl: json["mainPhotoUrl"],
        mainVideoUrl: json["mainVideoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "keyValue": keyValueValues.reverse[keyValue],
        "productGroupId": productGroupId,
        // "productGroupName": productGroupNameValues.reverse[productGroupName],
        "companyId": companyId,
        "companyName": companyName,
        "categoryId": categoryId,
        "categoryName": categoryNameValues.reverse[categoryName],
        "modelNumber": modelNumber,
        "productTypeId": productTypeId,
        "productTypeName": productTypeNameValues.reverse[productTypeName],
        "brandName": brandNameValues.reverse[brandName],
        "unitMeasurementId": unitMeasurementId,
        "unitMeasurementName": unitMeasurementNameValues.reverse[unitMeasurementName],
        "fboPriceStart": fboPriceStart,
        "fboPriceEnd": fboPriceEnd,
        "moqUnit": moqUnit,
        "unitPrice": unitPrice,
        "stock": stock,
        "packageLength": packageLength,
        "packageWidth": packageWidth,
        "packageHeight": packageHeight,
        "packageWeight": packageWeight,
        "productStatus": productStatus,
        "mainPhotoUrl": mainPhotoUrl,
        "mainVideoUrl": mainVideoUrl,
    };
    
      @override
      List<Object?> get props => [
        id, 
        name, 
        keyValue, 
        productGroupId, 
        // productGroupName, 
        companyId, 
        companyName, 
        categoryId, 
        categoryName, 
        modelNumber, 
        productTypeId, 
        productTypeName, 
        brandName, 
        unitMeasurementId, 
        unitMeasurementName, 
        fboPriceStart, 
        fboPriceEnd, 
        moqUnit, 
        unitPrice, 
        stock, 
        packageLength, 
        packageWidth, 
        packageHeight, 
        packageWeight, 
        productStatus, 
        mainPhotoUrl, 
        mainVideoUrl,
      ];
}

enum BrandName {
    MARCA_XYZ
}

final brandNameValues = EnumValues({
    "MARCA XYZ": BrandName.MARCA_XYZ
});

enum CategoryName {
    METALLURGY_CHEMICALS_RUBBER_AND_PLASTICS
}

final categoryNameValues = EnumValues({
    "Metallurgy, Chemicals, Rubber and Plastics": CategoryName.METALLURGY_CHEMICALS_RUBBER_AND_PLASTICS
});

enum KeyValue {
    SAMPLE
}

final keyValueValues = EnumValues({
    "SAMPLE": KeyValue.SAMPLE
});

enum ProductGroupName {
    BOOKS
}

final productGroupNameValues = EnumValues({
    "Books": ProductGroupName.BOOKS
});

enum ProductTypeName {
    FITNESS_EQUIPMENT
}

final productTypeNameValues = EnumValues({
    "Fitness Equipment": ProductTypeName.FITNESS_EQUIPMENT
});

enum UnitMeasurementName {
    KILOGRAM
}

final unitMeasurementNameValues = EnumValues({
    "Kilogram": UnitMeasurementName.KILOGRAM
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
