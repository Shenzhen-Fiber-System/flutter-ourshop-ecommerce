
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

class FilteredProduct extends Equatable {
    final String id;
    final String name;
    final String? keyValue;
    final String? productGroupId;
    final String? companyId;
    final String? companySubdomain;
    final String? subCategoryId;
    final String? categoryId;
    final String? categoryName;
    final String? modelNumber;
    final String? productTypeId;
    final String? brandName;
    final String? unitMeasurementId;
    final double? fboPriceStart;
    final double? fboPriceEnd;
    final double? moqUnit;
    final double? stock;
    final double? packageLength;
    final double? packageWidth;
    final double? packageHeight;
    final double? packageWeight;
    final double? unitPrice;
    final List<Certification> specifications;
    final List<Certification> details;
    final List<Certification> certifications;
    final String? productStatus;
    final List<FilteredProductMedia> productPhotos;
    final List<FilteredProductMedia> productVideos;
    final String? mainPhotoUrl;
    final String? mainVideoUrl;
    final ProductReviewInfo? productReviewInfo;
    final List<PriceRange> priceRanges;

    final bool selected;
    final int quantity;

    const FilteredProduct({
        required this.id,
        required this.name,
        this.keyValue,
        this.productGroupId,
        this.companyId,
        this.companySubdomain,
        this.subCategoryId,
        this.categoryId,
        this.categoryName,
        this.modelNumber,
        this.productTypeId,
        this.brandName,
        this.unitMeasurementId,
        this.fboPriceStart,
        this.fboPriceEnd,
        this.moqUnit,
        this.stock,
        this.packageLength,
        this.packageWidth,
        this.packageHeight,
        this.packageWeight,
        this.unitPrice,
        required this.specifications,
        required this.details,
        required this.certifications,
        this.productStatus,
        required this.productPhotos,
        required this.productVideos,
        this.mainPhotoUrl,
        this.mainVideoUrl,
        required this.productReviewInfo,
        required this.priceRanges,
        this.selected = false,
        this.quantity = 0,
    });

    FilteredProduct copyWith({
        String? id,
        String? name,
        String? keyValue,
        String? productGroupId,
        String? companyId,
        String? companySubdomain,
        String? subCategoryId,
        String? categoryId,
        String? categoryName,
        String? modelNumber,
        String? productTypeId,
        String? brandName,
        String? unitMeasurementId,
        double? fboPriceStart,
        double? fboPriceEnd,
        double? moqUnit,
        double? stock,
        double? packageLength,
        double? packageWidth,
        double? packageHeight,
        double? packageWeight,
        double? unitPrice,
        List<Certification>? specifications,
        List<Certification>? details,
        List<Certification>? certifications,
        String? productStatus,
        List<FilteredProductMedia>? productPhotos,
        List<FilteredProductMedia>? productVideos,
        String? mainPhotoUrl,
        String? mainVideoUrl,
        ProductReviewInfo? productReviewInfo,
        List<PriceRange>? priceRanges,
        bool? selected,
        int? quantity,
        List<Review>? reviews,
    }) => 
        FilteredProduct(
            id: id ?? this.id,
            name: name ?? this.name,
            keyValue: keyValue ?? this.keyValue,
            productGroupId: productGroupId ?? this.productGroupId,
            companyId: companyId ?? this.companyId,
            companySubdomain: companySubdomain ?? this.companySubdomain,
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
            productPhotos: productPhotos ?? this.productPhotos,
            productVideos: productVideos ?? this.productVideos,
            mainPhotoUrl: mainPhotoUrl ?? this.mainPhotoUrl,
            mainVideoUrl: mainVideoUrl ?? this.mainVideoUrl,
            productReviewInfo: productReviewInfo ?? this.productReviewInfo,
            priceRanges: priceRanges ?? this.priceRanges,
            selected: selected ?? this.selected,
            quantity: quantity ?? this.quantity,
        );

    factory FilteredProduct.fromJson(Map<String, dynamic> json) => FilteredProduct(
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
        fboPriceStart: json["fboPriceStart"]?.toDouble(),
        fboPriceEnd: json["fboPriceEnd"]?.toDouble(),
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
        productPhotos: List<FilteredProductMedia>.from(json["photos"].map((x) => FilteredProductMedia.fromJson(x))),
        productVideos: List<FilteredProductMedia>.from(json["videos"].map((x) => FilteredProductMedia.fromJson(x))),
        mainPhotoUrl: json["mainPhotoUrl"],
        mainVideoUrl: json["mainVideoUrl"],
        productReviewInfo: ProductReviewInfo.fromJson(json["productReviewInfo"]),
        priceRanges: List<PriceRange>.from(json["priceRanges"].map((x) => PriceRange.fromJson(x))),
    );

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
    selected,
    quantity,
  ];
}


class PriceRange {
    final String id;
    final int quantityFrom;
    final int quantityTo;
    final double price;

    PriceRange({
        required this.id,
        required this.quantityFrom,
        required this.quantityTo,
        required this.price,
    });

    PriceRange copyWith({
        String? id,
        int? quantityFrom,
        int? quantityTo,
        double? price,
    }) => 
        PriceRange(
            id: id ?? this.id,
            quantityFrom: quantityFrom ?? this.quantityFrom,
            quantityTo: quantityTo ?? this.quantityTo,
            price: price ?? this.price,
        );

    factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        id: json["id"],
        quantityFrom: json["quantityFrom"],
        quantityTo: json["quantityTo"],
        price: json["price"]?.toDouble(),
    );

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

}

class FilteredProductMedia {
    final String id;
    // final String? productId;
    final FilteredProductVideoPhoto? photo;
    // final int? importanceOrder;
    final FilteredProductVideoPhoto? video;

    FilteredProductMedia({
        required this.id,
        // this.productId,
        this.photo,
        // this.importanceOrder,
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
            // productId: productId ?? this.productId,
            photo: photo ?? this.photo,
            // importanceOrder: importanceOrder ?? this.importanceOrder,
            video: video ?? this.video,
        );

    factory FilteredProductMedia.fromJson(Map<String, dynamic> json) => FilteredProductMedia(
        id: json["id"],
        // productId: json["productId"],
        photo: json["photo"] == null ? null : FilteredProductVideoPhoto.fromJson(json["photo"]),
        // importanceOrder: json["importanceOrder"],
        video: json["video"] == null ? null : FilteredProductVideoPhoto.fromJson(json["video"]),
    );

}

class FilteredProductVideoPhoto {
    // final String id;
    // final String name;
    final String url;
    // final int? importanceOrder;
    // final String? companyName;

    FilteredProductVideoPhoto({
        // required this.id,
        // required this.name,
        required this.url,
        // this.importanceOrder,
        // this.companyName,
    });

    FilteredProductVideoPhoto copyWith({
        String? id,
        String? name,
        String? url,
        int? importanceOrder,
        String? companyName,
    }) => 
        FilteredProductVideoPhoto(
            // id: id ?? this.id,
            // name: name ?? this.name,
            url: url ?? this.url,
            // importanceOrder: importanceOrder ?? this.importanceOrder,
            // companyName: companyName ?? this.companyName,
        );

    factory FilteredProductVideoPhoto.fromJson(Map<String, dynamic> json) => FilteredProductVideoPhoto(
        // id: json["id"],
        // name: json["name"],
        url: json["url"],
        // importanceOrder: json["importanceOrder"],
        // companyName: json["companyName"],
    );
}

class FilteredGroupCountries extends Equatable {
    final String id;
    final String name;
    final dynamic countriesIds;
    final List<Country> countries;

    const FilteredGroupCountries({
        required this.id,
        required this.name,
        required this.countriesIds,
        required this.countries,
    });

    FilteredGroupCountries copyWith({
        String? id,
        String? name,
        dynamic countriesIds,
        List<Country>? countries,
    }) => 
        FilteredGroupCountries(
            id: id ?? this.id,
            name: name ?? this.name,
            countriesIds: countriesIds ?? this.countriesIds,
            countries: countries ?? this.countries,
        );

    factory FilteredGroupCountries.fromJson(Map<String, dynamic> json) => FilteredGroupCountries(
        id: json["id"],
        name: json["name"],
        countriesIds: json["countriesIds"],
        countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
    );
    
    @override
    
    List<Object?> get props => [
        id,
        name,
        countriesIds,
        countries,
    ];
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
    // final List<dynamic> orderStatuses;
    final double subTotal;
    final double discount;
    final double total;
    // final DateTime createdAt;

    const FilteredOrders({
        required this.id,
        required this.orderNumber,
        required this.customerId,
        this.companyId,
        required this.customerName,
        required this.orderStatus,
        required this.shippingAddressId,
        // this.orderStatuses = const [],
        required this.subTotal,
        required this.discount,
        required this.total,
        // required this.createdAt,
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
        // List<dynamic>? orderStatuses,
        double? subTotal,
        double? discount,
        double? total,
        // DateTime? createdAt,
    }) => 
        FilteredOrders(
            id: id ?? this.id,
            orderNumber: orderNumber ?? this.orderNumber,
            customerId: customerId ?? this.customerId,
            companyId: companyId ?? this.companyId,
            customerName: customerName ?? this.customerName,
            orderStatus: orderStatus ?? this.orderStatus,
            shippingAddressId: shippingAddressId ?? this.shippingAddressId,
            // orderStatuses: orderStatuses ?? this.orderStatuses,
            subTotal: subTotal ?? this.subTotal,
            discount: discount ?? this.discount,
            total: total ?? this.total,
            // createdAt: createdAt ?? this.createdAt,
        );

    factory FilteredOrders.fromJson(Map<String, dynamic> json) => FilteredOrders(
        id: json["id"],
        orderNumber: json["orderNumber"],
        customerId: json["customerId"],
        companyId: json["companyId"],
        customerName: json["customerName"],
        orderStatus: json["orderStatus"],
        shippingAddressId: json["shippingAddressId"],
        // orderStatuses: List<dynamic>.from(json["orderStatuses"].map((x) => x)),
        subTotal: json["subTotal"],
        discount: json["discount"],
        total: json["total"],
        // createdAt: DateTime.parse(json["createdAt"]),
    );
    
      @override
      List<Object?> get props => [
        id,
        orderNumber,
        customerId,
        companyId,
        customerName,
        orderStatus,
        shippingAddressId,
        // orderStatuses,
        subTotal,
        discount,
        total,
        // createdAt,
      ];
}

// My company - Banks 
class FilteredBanks extends Equatable {
    final String? name;
    final String? id;
    final String? countryId;

    const FilteredBanks({
        this.id,
        this.name,
        this.countryId,
    });

    FilteredBanks copyWith({
        String? id,
        String? name,
        String? countryId,
    }) => 
      FilteredBanks(
          id: id ?? this.id,
          name: name ?? this.name,
          countryId: countryId ?? this.countryId,
      );

    factory FilteredBanks.fromJson(Map<String, dynamic> json) => FilteredBanks(
        id: json["id"],
        name: json["name"],
        countryId: json["countryId"],
    );
    
    @override
    List<Object?> get props => [
        id,
        name,
        countryId,
    ];
}
//shipping rates

class FilteredShippingRate extends Equatable {
    final String id;
    final String? name;
    final String? countryId;
    final String? countryGroupId;
    final dynamic companyId;
    final List<String> productIds;
    final List<FilteredProduct> products;
    final List<ShippingRange> shippingRanges;

    const FilteredShippingRate({
        required this.id,
        required this.name,
        required this.countryId,
        required this.countryGroupId,
        required this.companyId,
        required this.productIds,
        required this.products,
        required this.shippingRanges,
    });

    FilteredShippingRate copyWith({
        String? id,
        String? name,
        String? countryId,
        String? countryGroupId,
        dynamic companyId,
        List<String>? productIds,
        List<FilteredProduct>? products,
        List<ShippingRange>? shippingRanges,
    }) => 
        FilteredShippingRate(
            id: id ?? this.id,
            name: name ?? this.name,
            countryId: countryId ?? this.countryId,
            countryGroupId: countryGroupId ?? this.countryGroupId,
            companyId: companyId ?? this.companyId,
            productIds: productIds ?? this.productIds,
            products: products ?? this.products,
            shippingRanges: shippingRanges ?? this.shippingRanges,
        );

    factory FilteredShippingRate.fromJson(Map<String, dynamic> json) => FilteredShippingRate(
        id: json["id"],
        name: json["name"],
        countryId: json["countryId"],
        countryGroupId: json["countryGroupId"],
        companyId: json["companyId"],
        productIds: List<String>.from(json["productIds"].map((x) => x)),
        products: List<FilteredProduct>.from(json["products"].map((x) => FilteredProduct.fromJson(x))),
        shippingRanges: List<ShippingRange>.from(json["shippingRanges"].map((x) => ShippingRange.fromJson(x))),
    );
    
    @override
    List<Object?> get props => [
        id,
        name,
        countryId,
        countryGroupId,
        companyId,
        productIds,
        products,
        shippingRanges,
    ];
}


class ShippingRange extends Equatable {
    final String id;
    // final String shippingRateId;
    final int? quantityFrom;
    final int? quantityTo;
    final double? price;

    const ShippingRange({
        required this.id,
        // required this.shippingRateId,
        this.quantityFrom,
        this.quantityTo,
        this.price,
    });

    ShippingRange copyWith({
        String? id,
        // String? shippingRateId,
        int? quantityFrom,
        int? quantityTo,
        double? price,
    }) => 
        ShippingRange(
            id: id ?? this.id,
            // shippingRateId: shippingRateId ?? this.shippingRateId,
            quantityFrom: quantityFrom ?? this.quantityFrom,
            quantityTo: quantityTo ?? this.quantityTo,
            price: price ?? this.price,
        );

    factory ShippingRange.fromJson(Map<String, dynamic> json) => ShippingRange(
        id: json["id"],
        // shippingRateId: json["shippingRateId"],
        // quantityFrom: _toDouble(json["quantityFrom"]),
        // quantityTo: _toDouble(json["quantityTo"]),
        quantityFrom: json["quantityFrom"],
        quantityTo: json["quantityTo"],
        price: _toDouble(json["price"]),
    );

    static double? _toDouble(dynamic value) {
      if (value == null) return null;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return double.tryParse(value.toString());
    }
    
    @override
    List<Object?> get props => [
        id,
        quantityFrom,
        quantityTo,
        price,
    ];
}

//Offers
class FilteredOffers {
    final String id;
    final String name;
    final String description;
    final DateTime dateFrom;
    final DateTime dateTo;
    final bool showOffer;

    FilteredOffers({
        required this.id,
        required this.name,
        required this.description,
        required this.dateFrom,
        required this.dateTo,
        required this.showOffer,
    });

    FilteredOffers copyWith({
        String? id,
        String? name,
        String? description,
        DateTime? dateFrom,
        DateTime? dateTo,
        bool? showOffer,
    }) => 
        FilteredOffers(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            dateFrom: dateFrom ?? this.dateFrom,
            dateTo: dateTo ?? this.dateTo,
            showOffer: showOffer ?? this.showOffer,
        );

    factory FilteredOffers.fromJson(Map<String, dynamic> json) => FilteredOffers(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        dateFrom: DateTime.parse(json["dateFrom"]),
        dateTo: DateTime.parse(json["dateTo"]),
        showOffer: json["showOffer"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "dateFrom": dateFrom.toIso8601String(),
        "dateTo": dateTo.toIso8601String(),
        "showOffer": showOffer,
    };
}

//communicatin -submittions
class FilteredRequests extends Equatable {
    final String? id;
    final String? requestTypeId;
    final String? companyId;
    final String? email;
    final String? fullName;
    final String? phoneNumber;
    final String? phoneNumberCode;
    final String? title;
    final String? message;
    final dynamic secondaryMessage;
    final String? target;
    final dynamic isReadAt;
    final dynamic language;
    final bool? read;

    const FilteredRequests({
        this.id,
        this.requestTypeId,
        this.companyId,
        this.email,
        this.fullName,
        this.phoneNumber,
        this.phoneNumberCode,
        this.title,
        this.message,
        this.secondaryMessage,
        this.target,
        this.isReadAt,
        this.language,
        this.read,
    });

    FilteredRequests copyWith({
        String? id,
        String? requestTypeId,
        String? companyId,
        String? email,
        String? fullName,
        String? phoneNumber,
        String? phoneNumberCode,
        String? title,
        String? message,
        dynamic secondaryMessage,
        String? target,
        dynamic isReadAt,
        dynamic language,
        bool? read,
    }) => 
        FilteredRequests(
            id: id ?? this.id,
            requestTypeId: requestTypeId ?? this.requestTypeId,
            companyId: companyId ?? this.companyId,
            email: email ?? this.email,
            fullName: fullName ?? this.fullName,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            phoneNumberCode: phoneNumberCode ?? this.phoneNumberCode,
            title: title ?? this.title,
            message: message ?? this.message,
            secondaryMessage: secondaryMessage ?? this.secondaryMessage,
            target: target ?? this.target,
            isReadAt: isReadAt ?? this.isReadAt,
            language: language ?? this.language,
            read: read ?? this.read,
        );

    factory FilteredRequests.fromJson(Map<String, dynamic> json) => FilteredRequests(
        id: json["id"],
        requestTypeId: json["requestTypeId"],
        companyId: json["companyId"],
        email: json["email"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        phoneNumberCode: json["phoneNumberCode"],
        title: json["title"],
        message: json["message"],
        secondaryMessage: json["secondaryMessage"],
        target: json["target"],
        isReadAt: json["isReadAt"],
        language: json["language"],
        read: json["read"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "requestTypeId": requestTypeId,
        "companyId": companyId,
        "email": email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "phoneNumberCode": phoneNumberCode,
        "title": title,
        "message": message,
        "secondaryMessage": secondaryMessage,
        "target": target,
        "isReadAt": isReadAt,
        "language": language,
        "read": read,
    };
    
      @override
      
      List<Object?> get props => [
        id,
        requestTypeId,
        companyId,
        email,
        fullName,
        phoneNumber,
        phoneNumberCode,
        title,
        message,
        secondaryMessage,
        target,
        isReadAt,
        language,
        read,
      ];
}


class FilteredOfferTypes extends Equatable {
    final String? id;
    final String? name;
    final String? description;
    final DateTime? dateFrom;
    final DateTime? dateTo;
    final bool? showOffer;

    const FilteredOfferTypes({
        this.id,
        this.name,
        this.description,
        this.dateFrom,
        this.dateTo,
        this.showOffer,
    });

    FilteredOfferTypes copyWith({
        String? id,
        String? name,
        String? description,
        DateTime? dateFrom,
        DateTime? dateTo,
        bool? showOffer,
    }) => 
        FilteredOfferTypes(
            id: id ?? this.id,
            name: name ?? this.name,
            description: description ?? this.description,
            dateFrom: dateFrom ?? this.dateFrom,
            dateTo: dateTo ?? this.dateTo,
            showOffer: showOffer ?? this.showOffer,
        );

    factory FilteredOfferTypes.fromJson(Map<String, dynamic> json) => FilteredOfferTypes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        dateFrom: json["dateFrom"] == null ? null : DateTime.parse(json["dateFrom"]),
        dateTo: json["dateTo"] == null ? null : DateTime.parse(json["dateTo"]),
        showOffer: json["showOffer"],
    );
    
      @override
      
      List<Object?> get props => [
        id,
        name,
        description,
        dateFrom,
        dateTo,
        showOffer,
      ];
}

class FilteredOfferProduct {
    final String? id;
    final String? discountType;
    final double? discountValue;
    final DateTime? startDate;
    final DateTime? endDate;
    final int? minimumPurchaseQuantity;
    final int? maximumDiscountQuantity;
    final double? maximumDiscountAmount;
    final String? status;
    final dynamic offerTypeId;
    final FilteredOfferTypes? offerType;
    final FilteredProduct? product;
    final dynamic productId;
    final dynamic productUnitPriceWithDiscount;

    FilteredOfferProduct({
        this.id,
        this.discountType,
        this.discountValue,
        this.startDate,
        this.endDate,
        this.minimumPurchaseQuantity,
        this.maximumDiscountQuantity,
        this.maximumDiscountAmount,
        this.status,
        this.offerTypeId,
        this.offerType,
        this.product,
        this.productId,
        this.productUnitPriceWithDiscount,
    });

    FilteredOfferProduct copyWith({
        String? id,
        String? discountType,
        double? discountValue,
        DateTime? startDate,
        DateTime? endDate,
        int? minimumPurchaseQuantity,
        int? maximumDiscountQuantity,
        double? maximumDiscountAmount,
        String? status,
        dynamic offerTypeId,
        FilteredOfferTypes? offerType,
        FilteredProduct? product,
        dynamic productId,
        dynamic productUnitPriceWithDiscount,
    }) => 
        FilteredOfferProduct(
            id: id ?? this.id,
            discountType: discountType ?? this.discountType,
            discountValue: discountValue ?? this.discountValue,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
            minimumPurchaseQuantity: minimumPurchaseQuantity ?? this.minimumPurchaseQuantity,
            maximumDiscountQuantity: maximumDiscountQuantity ?? this.maximumDiscountQuantity,
            maximumDiscountAmount: maximumDiscountAmount ?? this.maximumDiscountAmount,
            status: status ?? this.status,
            offerTypeId: offerTypeId ?? this.offerTypeId,
            offerType: offerType ?? this.offerType,
            product: product ?? this.product,
            productId: productId ?? this.productId,
            productUnitPriceWithDiscount: productUnitPriceWithDiscount ?? this.productUnitPriceWithDiscount,
        );

    factory FilteredOfferProduct.fromMap(Map<String, dynamic> json) => FilteredOfferProduct(
        id: json["id"],
        discountType: json["discountType"],
        discountValue: json["discountValue"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        minimumPurchaseQuantity: json["minimumPurchaseQuantity"],
        maximumDiscountQuantity: json["maximumDiscountQuantity"],
        maximumDiscountAmount: json["maximumDiscountAmount"],
        status: json["status"],
        offerTypeId: json["offerTypeId"],
        offerType: json["offerType"] == null ? null : FilteredOfferTypes.fromJson(json["offerType"]),
        product: json["product"] == null ? null : FilteredProduct.fromJson(json["product"]),
        productId: json["productId"],
        productUnitPriceWithDiscount: json["productUnitPriceWithDiscount"],
    );

    DiscountType getDiscountType() {
      switch (discountType) {
        case 'PERCENTAGE':
          return DiscountType.PERCENTAGE;
        case 'AMOUNT':
          return DiscountType.FIXED;
        default:
          return DiscountType.UNKNOWN;
      }
    }
    
    double get newprice{
      if (discountType == 'PERCENTAGE') {
        return product!.unitPrice! - (product!.unitPrice! * discountValue! / 100);
      } else {
        return product!.unitPrice! - discountValue!;
      }
    }
}


enum DiscountType {
  PERCENTAGE,
  FIXED,
  UNKNOWN,
}
