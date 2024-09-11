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
    final List<Photo> photos;
    final List<Photo> videos;
    final dynamic mainPhotoUrl;
    final dynamic mainVideoUrl;
    final bool selected;
    final ProductReviewInfo? productReviewInfo;
    final int quantity;
    final List<Review>? reviews;

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
        required this.photos,
        required this.videos,
        required this.mainPhotoUrl,
        required this.mainVideoUrl,
        this.selected = false,
        this.productReviewInfo,
        this.quantity = 0,
        this.reviews = const [],
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
        photos: json['photos'] != null ? List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))) : [],
        videos: json['photos'] != null ? List<Photo>.from(json["videos"].map((x) => Photo.fromJson(x))) : [],
        mainPhotoUrl: json["mainPhotoUrl"],
        mainVideoUrl: json["mainVideoUrl"],
        productReviewInfo: ProductReviewInfo.fromJson(json["productReviewInfo"]),        
    );


    Product copyWith({
      String?id,
      String?name,
      String?keyValue,
      String?productGroupId,
      String?companyId,
      dynamic subCategoryId,
      String?categoryId,
      String?categoryName,
      String?modelNumber,
      String?productTypeId,
      String?brandName,
      String?unitMeasurementId,
      double?fboPriceStart,
      double?fboPriceEnd,
      dynamic moqUnit,
      dynamic stock,
      double?packageLength,
      double?packageWidth,
      double?packageHeight,
      double?packageWeight,
      double?unitPrice,
      List<Certification>?specifications,
      List<Certification>?details,
      List<Certification>?certifications,
      String?productStatus,
      List<Photo>? photos,
      List<Photo>? videos,
      dynamic mainPhotoUrl,
      dynamic mainVideoUrl,
      bool?selected,
      ProductReviewInfo? productReviewInfo,
      int? quantity,
      List<Review>? reviews,
    }) => Product(
      id: id ?? this.id,
      name: name ?? this.name,
      keyValue: keyValue ?? this.keyValue,
      productGroupId: productGroupId ?? this.productGroupId,
      companyId: companyId ?? this.companyId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      modelNumber: modelNumber ?? this.modelNumber,
      productTypeId: productTypeId ?? this.productTypeId,
      brandName: brandName ?? this.brandName,
      unitMeasurementId: unitMeasurementId ?? this.unitMeasurementId,
      fboPriceStart: fboPriceStart ?? this.fboPriceStart,
      fboPriceEnd: fboPriceEnd ?? this.fboPriceEnd,
      moqUnit: moqUnit ?? this.moqUnit,
      stock: stock ?? this.stock,
      packageLength: packageLength ?? this.packageLength,
      packageWidth: packageWidth ?? this.packageWidth,
      packageHeight: packageHeight ?? this.packageHeight,
      packageWeight: packageWeight ?? this.packageWeight,
      unitPrice: unitPrice ?? this.unitPrice,
      specifications: specifications ?? this.specifications,
      details: details ?? this.details,
      certifications: certifications ?? this.certifications,
      productStatus: productStatus ?? this.productStatus,
      photos: photos ?? this.photos,
      videos: videos ?? this.videos,
      mainPhotoUrl: mainPhotoUrl ?? this.mainPhotoUrl,
      mainVideoUrl: mainVideoUrl ?? this.mainVideoUrl,
      selected: selected ?? this.selected,
      productReviewInfo: productReviewInfo ?? this.productReviewInfo,
      quantity: quantity ?? this.quantity,
      reviews: reviews ?? this.reviews,
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
        "productPhotos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "productVideos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "mainPhotoUrl": mainPhotoUrl,
        "mainVideoUrl": mainVideoUrl,
        "productReviewInfo": productReviewInfo?.toJson(),
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
      photos, 
      videos, 
      mainPhotoUrl, 
      mainVideoUrl,
      selected,
      quantity,
      reviews,
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

class Photo {
    final String id;
    final String name;
    final String url;
    final int importanceOrder;

    Photo({
        required this.id,
        required this.name,
        required this.url,
        required this.importanceOrder,
    });

    Photo copyWith({
        String? id,
        String? name,
        String? url,
        int? importanceOrder,
        dynamic companyName,
    }) => 
        Photo(
            id: id ?? this.id,
            name: name ?? this.name,
            url: url ?? this.url,
            importanceOrder: importanceOrder ?? this.importanceOrder,

        );

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
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
}

class ProductReviewInfo {
    final double ratingAvg;
    final int reviewCount;
    final List<Summary> summary;

    ProductReviewInfo({
        required this.ratingAvg,
        required this.reviewCount,
        required this.summary,
    });

    ProductReviewInfo copyWith({
        double? ratingAvg,
        int? reviewCount,
        List<Summary>? summary,
    }) => 
        ProductReviewInfo(
            ratingAvg: ratingAvg ?? this.ratingAvg,
            reviewCount: reviewCount ?? this.reviewCount,
            summary: summary ?? this.summary,
        );

    factory ProductReviewInfo.fromJson(Map<String, dynamic> json) => ProductReviewInfo(
        ratingAvg: json["ratingAvg"]?.toDouble(),
        reviewCount: json["reviewCount"],
        summary: List<Summary>.from(json["summary"].map((x) => Summary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ratingAvg": ratingAvg,
        "reviewCount": reviewCount,
        "summary": List<dynamic>.from(summary.map((x) => x.toJson())),
    };
}

class Summary {
    final int rating;
    final int reviewCount;
    final int totalReviews;
    final double percentage;

    Summary({
        required this.rating,
        required this.reviewCount,
        required this.totalReviews,
        required this.percentage,
    });

    Summary copyWith({
        int? rating,
        int? reviewCount,
        int? totalReviews,
        double? percentage,
    }) => 
        Summary(
            rating: rating ?? this.rating,
            reviewCount: reviewCount ?? this.reviewCount,
            totalReviews: totalReviews ?? this.totalReviews,
            percentage: percentage ?? this.percentage,
        );

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        rating: json["rating"],
        reviewCount: json["reviewCount"],
        totalReviews: json["totalReviews"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "reviewCount": reviewCount,
        "totalReviews": totalReviews,
        "percentage": percentage,
    };
}

class ReviewsResponse {
    final bool success;
    final String message;
    final List<Review> data;

    ReviewsResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    ReviewsResponse copyWith({
        bool? success,
        String? message,
        List<Review>? data,
    }) => 
        ReviewsResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory ReviewsResponse.fromJson(Map<String, dynamic> json) => ReviewsResponse(
        success: json["success"],
        message: json["message"],
        data: List<Review>.from(json["data"].map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Review extends Equatable {
    final String content;
    final String productId;
    final int rating;
    final String createdBy;
    final DateTime createdAt;
    final String fullName;

    const Review({
        required this.content,
        required this.productId,
        required this.rating,
        required this.createdBy,
        required this.createdAt,
        required this.fullName,
    });

    Review copyWith({
        String? content,
        String? productId,
        int? rating,
        String? createdBy,
        DateTime? createdAt,
        String? fullName,
    }) => 
        Review(
            content: content ?? this.content,
            productId: productId ?? this.productId,
            rating: rating ?? this.rating,
            createdBy: createdBy ?? this.createdBy,
            createdAt: createdAt ?? this.createdAt,
            fullName: fullName ?? this.fullName,
        );

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        content: json["content"],
        productId: json["productId"],
        rating: json["rating"],
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "productId": productId,
        "rating": rating,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "fullName": fullName,
    };
    
      @override
      List<Object?> get props => [
        content, 
        productId, 
        rating, 
        createdBy, 
        createdAt, 
        fullName,
      ];
}


// FILTERED PRODUCTS --- WE NEED TO REFACTOR THIS



