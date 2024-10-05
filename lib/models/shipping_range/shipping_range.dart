import '../../ui/pages/pages.dart';

class CalculateShippingRangeresponse extends Equatable {
    final bool? success;
    final String? message;
    final List<CalculateShippingRange>? data;

    const CalculateShippingRangeresponse({
        this.success,
        this.message,
        this.data,
    });

    CalculateShippingRangeresponse copyWith({
        bool? success,
        String? message,
        List<CalculateShippingRange>? data,
    }) => 
        CalculateShippingRangeresponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory CalculateShippingRangeresponse.fromJson(Map<String, dynamic> json) => CalculateShippingRangeresponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CalculateShippingRange>.from(json["data"]!.map((x) => CalculateShippingRange.fromJson(x))),
    );
    
    @override
    List<Object?> get props => [
        success,
        message,
        data,
    ];
}

class CalculateShippingRange extends Equatable {

    final ShippingRangeClass? shippingRange;
    final int? quantity;
    final int? quantityProducts;
    final double? price;
    final List<String>? productIds;

    const CalculateShippingRange({
        this.shippingRange,
        this.quantity,
        this.quantityProducts,
        this.price,
        this.productIds,
    });

    CalculateShippingRange copyWith({
        ShippingRangeClass? shippingRange,
        int? quantity,
        int? quantityProducts,
        double? price,
        List<String>? productIds,
    }) => 
        CalculateShippingRange(
            shippingRange: shippingRange ?? this.shippingRange,
            quantity: quantity ?? this.quantity,
            quantityProducts: quantityProducts ?? this.quantityProducts,
            price: price ?? this.price,
            productIds: productIds ?? this.productIds,
        );

    factory CalculateShippingRange.fromJson(Map<String, dynamic> json) => CalculateShippingRange(
        shippingRange: json["shippingRange"] == null ? null : ShippingRangeClass.fromJson(json["shippingRange"]),
        quantity: json["quantity"],
        quantityProducts: json["quantityProducts"],
        price: json["price"],
        productIds: json["productIds"] == null ? [] : List<String>.from(json["productIds"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "shippingRange": shippingRange?.toJson(),
        "quantity": quantity,
        "quantityProducts": quantityProducts,
        "price": price,
        "productIds": productIds == null ? [] : List<dynamic>.from(productIds!.map((x) => x)),
    };
    
    @override
    List<Object?> get props => [
        shippingRange,
        quantity,
        quantityProducts,
        price,
        productIds,
    ];
}

class ShippingRangeClass extends Equatable {
    final String? id;
    // final String? shippingRateId;
    final int? quantityFrom;
    final int? quantityTo;
    final double? price;

    const ShippingRangeClass({
        this.id,
        // this.shippingRateId,
        this.quantityFrom,
        this.quantityTo,
        this.price,
    });

    ShippingRangeClass copyWith({
        String? id,
        String? shippingRateId,
        int? quantityFrom,
        int? quantityTo,
        double? price,
    }) => 
        ShippingRangeClass(
            id: id ?? this.id,
            // shippingRateId: shippingRateId ?? this.shippingRateId,
            quantityFrom: quantityFrom ?? this.quantityFrom,
            quantityTo: quantityTo ?? this.quantityTo,
            price: price ?? this.price,
        );

    factory ShippingRangeClass.fromJson(Map<String, dynamic> json) => ShippingRangeClass(
        id: json["id"],
        // shippingRateId: json["shippingRateId"],
        quantityFrom: json["quantityFrom"],
        quantityTo: json["quantityTo"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // "shippingRateId": shippingRateId,
        "quantityFrom": quantityFrom,
        "quantityTo": quantityTo,
        "price": price,
    };
    
    @override
    List<Object?> get props => [
        id,
        // shippingRateId,
        quantityFrom,
        quantityTo,
        price,
    ];
}
