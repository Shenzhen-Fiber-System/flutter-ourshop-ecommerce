
import '../ui/pages/pages.dart';

class FilteredResponse<T> extends Equatable {
  final bool success;
  final String message;
  final FilteredData<T> data;

  const FilteredResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  FilteredResponse<T> copyWith({
    bool? success,
    String? message,
    FilteredData<T>? data,
  }) => 
      FilteredResponse<T>(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory FilteredResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT, // Función de mapeo para el tipo genérico T
  ) =>
      FilteredResponse<T>(
        success: json["success"],
        message: json["message"],
        data: FilteredData<T>.fromJson(json["data"], fromJsonT),
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

class FilteredData<T> extends Equatable {
  final List<T> content;
  final int totalElements;
  final int page;
  final int pageSize;
  final int totalPages;

  const FilteredData({
    required this.content,
    required this.totalElements,
    required this.page,
    required this.pageSize,
    required this.totalPages,
  });

  FilteredData<T> copyWith({
    List<T>? content,
    int? totalElements,
    int? page,
    int? pageSize,
    int? totalPages,
  }) => 
    FilteredData<T>(
      content: content ?? this.content,
      totalElements: totalElements ?? this.totalElements,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
    );

  factory FilteredData.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return FilteredData<T>(
      content: List<T>.from(json["content"].map((item) => fromJsonT(item))),
      totalElements: json["totalElements"],
      page: json["page"],
      pageSize: json["pageSize"],
      totalPages: json["totalPages"],
    );
  }

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => (x as dynamic).toJson())),
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

// prodocts

class FilteredProducts extends Equatable {
  final String id;
  final String name;
  final String keyValue;
  final String productGroupId;
  final String companyId;
  final String subCategoryId;
  final String categoryId;
  final String categoryName;
  final String modelNumber;
  final String productTypeId;
  final String brandName;
  final String unitMeasurementId;
  final dynamic fboPriceStart;  // Estos pueden ser null
  final dynamic fboPriceEnd;    // Estos pueden ser null
  final dynamic moqUnit;        // Estos pueden ser null
  final double stock;
  final double? packageLength;
  final double? packageWidth;
  final double? packageHeight;
  final double? packageWeight;
  final double? unitPrice;      // Marcado como nullable
  final List<Detail> specifications;
  final List<Detail> details;
  final List<dynamic> certifications;
  final String productStatus;
  final List<FilteredProductMedia> productPhotos;
  final List<FilteredProductMedia> productVideos;
  final String? mainPhotoUrl;   // Marcado como nullable
  final String? mainVideoUrl;   // Marcado como nullable
  final ProductReviewInfo productReviewInfo;
  final List<dynamic> priceRanges;

  const FilteredProducts({
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
    this.fboPriceStart,
    this.fboPriceEnd,
    this.moqUnit,
    required this.stock,
    required this.packageLength,
    required this.packageWidth,
    required this.packageHeight,
    required this.packageWeight,
    this.unitPrice,  // Ahora es nullable
    required this.specifications,
    required this.details,
    required this.certifications,
    required this.productStatus,
    required this.productPhotos,
    required this.productVideos,
    this.mainPhotoUrl,  // Ahora es nullable
    this.mainVideoUrl,  // Ahora es nullable
    required this.productReviewInfo,
    required this.priceRanges,
  });

  factory FilteredProducts.fromJson(Map<String, dynamic> json) => FilteredProducts(
    id: json["id"],
    name: json["name"],
    keyValue: json["keyValue"] ?? '',
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
    stock: (json["stock"] as num).toDouble(),
    packageLength: ((json["packageLength"] as num).toDouble()),
    packageWidth: (json["packageWidth"] as num).toDouble(),
    packageHeight: (json["packageHeight"] as num).toDouble(),
    packageWeight: (json["packageWeight"] as num).toDouble(),
    unitPrice: json["unitPrice"] != null ? (json["unitPrice"] as num).toDouble() : null,
    specifications: List<Detail>.from(json["specifications"].map((x) => Detail.fromJson(x))),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    certifications: List<dynamic>.from(json["certifications"].map((x) => x)),
    productStatus: json["productStatus"],
    productPhotos: List<FilteredProductMedia>.from(json["productPhotos"].map((x) => FilteredProductMedia.fromJson(x))),
    productVideos: List<FilteredProductMedia>.from(json["productVideos"].map((x) => FilteredProductMedia.fromJson(x))),
    mainPhotoUrl: json["mainPhotoUrl"],  // Nullable
    mainVideoUrl: json["mainVideoUrl"],  // Nullable
    productReviewInfo: ProductReviewInfo.fromJson(json["productReviewInfo"]),
    priceRanges: List<dynamic>.from(json["priceRanges"].map((x) => x)),
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
    "certifications": List<dynamic>.from(certifications.map((x) => x)),
    "productStatus": productStatus,
    "productPhotos": List<dynamic>.from(productPhotos.map((x) => x.toJson())),
    "productVideos": List<dynamic>.from(productVideos.map((x) => x.toJson())),
    "mainPhotoUrl": mainPhotoUrl,
    "mainVideoUrl": mainVideoUrl,
    "productReviewInfo": productReviewInfo.toJson(),
    "priceRanges": List<dynamic>.from(priceRanges.map((x) => x)),
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
    productReviewInfo,
    priceRanges,
  ];
}


class Detail {
    final String id;
    final String name;
    final String? description;
    final String productId;

    Detail({
        required this.id,
        required this.name,
        this.description,
        required this.productId,
    });

    Detail copyWith({
        String? id,
        String? name,
        String? description,
        String? productId,
    }) => 
        Detail(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            productId: productId ?? this.productId,
        );

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "productId": productId,
    };
}

class FilteredProductMedia {
    final String id;
    final String productId;
    final FilteredProductVideoPhoto? photo;
    final int importanceOrder;
    final FilteredProductVideoPhoto? video;

    FilteredProductMedia({
        required this.id,
        required this.productId,
        this.photo,
        required this.importanceOrder,
        this.video,
    });

    FilteredProductMedia copyWith({
        String? id,
        String? productId,
        FilteredProductVideoPhoto? photo,
        int? importanceOrder,
        FilteredProductVideoPhoto? video,
    }) => 
        FilteredProductMedia(
            id: id ?? this.id,
            productId: productId ?? this.productId,
            photo: photo ?? this.photo,
            importanceOrder: importanceOrder ?? this.importanceOrder,
            video: video ?? this.video,
        );

    factory FilteredProductMedia.fromJson(Map<String, dynamic> json) => FilteredProductMedia(
        id: json["id"],
        productId: json["productId"],
        photo: json["photo"] == null ? null : FilteredProductVideoPhoto.fromJson(json["photo"]),
        importanceOrder: json["importanceOrder"],
        video: json["video"] == null ? null : FilteredProductVideoPhoto.fromJson(json["video"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "photo": photo?.toJson(),
        "importanceOrder": importanceOrder,
        "video": video?.toJson(),
    };
}

class FilteredProductVideoPhoto {
    final String id;
    final String name;
    final String url;
    final int importanceOrder;
    final dynamic companyName;

    FilteredProductVideoPhoto({
        required this.id,
        required this.name,
        required this.url,
        required this.importanceOrder,
        required this.companyName,
    });

    FilteredProductVideoPhoto copyWith({
        String? id,
        String? name,
        String? url,
        int? importanceOrder,
        dynamic companyName,
    }) => 
        FilteredProductVideoPhoto(
            id: id ?? this.id,
            name: name ?? this.name,
            url: url ?? this.url,
            importanceOrder: importanceOrder ?? this.importanceOrder,
            companyName: companyName ?? this.companyName,
        );

    factory FilteredProductVideoPhoto.fromJson(Map<String, dynamic> json) => FilteredProductVideoPhoto(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        importanceOrder: json["importanceOrder"],
        companyName: json["companyName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "importanceOrder": importanceOrder,
        "companyName": companyName,
    };
}



//Orders



class FilteredOrders extends Equatable {
    final String id;
    final String orderNumber;
    final String customerId;
    final dynamic companyId;
    final String customerName;
    final String orderStatus;
    final dynamic shippingAddressId;
    final dynamic orderItems;
    final List<dynamic> orderStatuses;
    final double subTotal;
    final double discount;
    final double total;
    final DateTime createdAt;

    const FilteredOrders({
        required this.id,
        required this.orderNumber,
        required this.customerId,
        required this.companyId,
        required this.customerName,
        required this.orderStatus,
        required this.shippingAddressId,
        required this.orderItems,
        required this.orderStatuses,
        required this.subTotal,
        required this.discount,
        required this.total,
        required this.createdAt,
    });

    FilteredOrders copyWith({
        String? id,
        String? orderNumber,
        String? customerId,
        dynamic companyId,
        String? customerName,
        String? orderStatus,
        dynamic shippingAddressId,
        dynamic orderItems,
        List<dynamic>? orderStatuses,
        double? subTotal,
        double? discount,
        double? total,
        DateTime? createdAt,
    }) => 
        FilteredOrders(
            id: id ?? this.id,
            orderNumber: orderNumber ?? this.orderNumber,
            customerId: customerId ?? this.customerId,
            companyId: companyId ?? this.companyId,
            customerName: customerName ?? this.customerName,
            orderStatus: orderStatus ?? this.orderStatus,
            shippingAddressId: shippingAddressId ?? this.shippingAddressId,
            orderItems: orderItems ?? this.orderItems,
            orderStatuses: orderStatuses ?? this.orderStatuses,
            subTotal: subTotal ?? this.subTotal,
            discount: discount ?? this.discount,
            total: total ?? this.total,
            createdAt: createdAt ?? this.createdAt,
        );

    factory FilteredOrders.fromJson(Map<String, dynamic> json) => FilteredOrders(
        id: json["id"],
        orderNumber: json["orderNumber"],
        customerId: json["customerId"],
        companyId: json["companyId"],
        customerName: json["customerName"],
        orderStatus: json["orderStatus"],
        shippingAddressId: json["shippingAddressId"],
        orderItems: json["orderItems"],
        orderStatuses: List<dynamic>.from(json["orderStatuses"].map((x) => x)),
        subTotal: json["subTotal"],
        discount: json["discount"],
        total: json["total"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderNumber": orderNumber,
        "customerId": customerId,
        "companyId": companyId,
        "customerName": customerName,
        "orderStatus": orderStatus,
        "shippingAddressId": shippingAddressId,
        "orderItems": orderItems,
        "orderStatuses": List<dynamic>.from(orderStatuses.map((x) => x)),
        "subTotal": subTotal,
        "discount": discount,
        "total": total,
        "createdAt": createdAt.toIso8601String(),
    };
    
      @override
      List<Object?> get props => [
        id,
        orderNumber,
        customerId,
        companyId,
        customerName,
        orderStatus,
        shippingAddressId,
        orderItems,
        orderStatuses,
        subTotal,
        discount,
        total,
        createdAt,
      ];
}