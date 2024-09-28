import '../../ui/pages/pages.dart';

class OrderResponse {
    final bool success;
    final String message;
    final Order data;

    OrderResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    OrderResponse copyWith({
        bool? success,
        String? message,
        Order? data,
    }) => 
        OrderResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        success: json["success"],
        message: json["message"],
        data: Order.fromJson(json["data"]),
    );
}


class Order {
    final String? id;
    final String? orderNumber;
    final String? customerId;
    final String? companyId;
    final String? customerName;
    final String? orderStatus;
    final List<OrderItem>? orderItems;
    final dynamic orderStatuses;
    final double? subTotal;
    final double? discount;
    final double? total;
    final DateTime? createdAt;
    final List<ShippingRangeCalculation>? shippingRangeCalculation;
    final dynamic addressLine1;
    final dynamic addressLine2;
    final dynamic addressLine3;
    final dynamic phoneNumber;
    final dynamic city;
    final dynamic state;
    final dynamic country;
    final dynamic zipCode;

    Order({
        this.id,
        this.orderNumber,
        this.customerId,
        this.companyId,
        this.customerName,
        this.orderStatus,
        this.orderItems,
        this.orderStatuses,
        this.subTotal,
        this.discount,
        this.total,
        this.createdAt,
        this.shippingRangeCalculation,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.phoneNumber,
        this.city,
        this.state,
        this.country,
        this.zipCode,
    });

    Order copyWith({
        String? id,
        String? orderNumber,
        String? customerId,
        String? companyId,
        String? customerName,
        String? orderStatus,
        List<OrderItem>? orderItems,
        dynamic orderStatuses,
        double? subTotal,
        double? discount,
        double? total,
        DateTime? createdAt,
        List<ShippingRangeCalculation>? shippingRangeCalculation,
        dynamic addressLine1,
        dynamic addressLine2,
        dynamic addressLine3,
        dynamic phoneNumber,
        dynamic city,
        dynamic state,
        dynamic country,
        dynamic zipCode,
    }) => 
        Order(
            id: id ?? this.id,
            orderNumber: orderNumber ?? this.orderNumber,
            customerId: customerId ?? this.customerId,
            companyId: companyId ?? this.companyId,
            customerName: customerName ?? this.customerName,
            orderStatus: orderStatus ?? this.orderStatus,
            orderItems: orderItems ?? this.orderItems,
            orderStatuses: orderStatuses ?? this.orderStatuses,
            subTotal: subTotal ?? this.subTotal,
            discount: discount ?? this.discount,
            total: total ?? this.total,
            createdAt: createdAt ?? this.createdAt,
            shippingRangeCalculation: shippingRangeCalculation ?? this.shippingRangeCalculation,
            addressLine1: addressLine1 ?? this.addressLine1,
            addressLine2: addressLine2 ?? this.addressLine2,
            addressLine3: addressLine3 ?? this.addressLine3,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            city: city ?? this.city,
            state: state ?? this.state,
            country: country ?? this.country,
            zipCode: zipCode ?? this.zipCode,
        );

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderNumber: json["orderNumber"],
        customerId: json["customerId"],
        companyId: json["companyId"],
        customerName: json["customerName"],
        orderStatus: json["orderStatus"],
        orderItems: json["orderItems"] == null ? [] : List<OrderItem>.from(json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
        orderStatuses: json["orderStatuses"],
        subTotal: json["subTotal"],
        discount: json["discount"],
        total: json["total"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        shippingRangeCalculation: json["shippingRangeCalculation"] == null ? [] : List<ShippingRangeCalculation>.from(json["shippingRangeCalculation"]!.map((x) => ShippingRangeCalculation.fromJson(x))),
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        addressLine3: json["addressLine3"],
        phoneNumber: json["phoneNumber"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zipCode"],
    );
}

class OrderItem  extends Equatable {
    final String? id;
    final String? orderId;
    final String? productId;
    final String? productName;
    final String? productCategoryName;
    final String? productUnitMeasurementName;
    final String? productMainPhotoUrl;
    final String? productCompanyId;
    final double? qty;
    final double? price;
    final double? discount;
    final double? total;
    final double? subTotal;
    final String? companyName;

    const OrderItem({
        this.id,
        this.orderId,
        this.productId,
        this.productName,
        this.productCategoryName,
        this.productUnitMeasurementName,
        this.productMainPhotoUrl,
        this.productCompanyId,
        this.qty,
        this.price,
        this.discount,
        this.total,
        this.subTotal,
        this.companyName,
    });

    OrderItem copyWith({
        String? id,
        String? orderId,
        String? productId,
        String? productName,
        String? productCategoryName,
        String? productUnitMeasurementName,
        String? productMainPhotoUrl,
        String? productCompanyId,
        double? qty,
        double? price,
        double? discount,
        double? total,
        double? subTotal,
        String? companyName,
    }) => 
        OrderItem(
            id: id ?? this.id,
            orderId: orderId ?? this.orderId,
            productId: productId ?? this.productId,
            productName: productName ?? this.productName,
            productCategoryName: productCategoryName ?? this.productCategoryName,
            productUnitMeasurementName: productUnitMeasurementName ?? this.productUnitMeasurementName,
            productMainPhotoUrl: productMainPhotoUrl ?? this.productMainPhotoUrl,
            productCompanyId: productCompanyId ?? this.productCompanyId,
            qty: qty ?? this.qty,
            price: price ?? this.price,
            discount: discount ?? this.discount,
            total: total ?? this.total,
            subTotal: subTotal ?? this.subTotal,
            companyName: companyName ?? this.companyName,
        );

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["orderId"],
        productId: json["productId"],
        productName: json["productName"],
        productCategoryName: json["productCategoryName"],
        productUnitMeasurementName: json["productUnitMeasurementName"],
        productMainPhotoUrl: json["productMainPhotoUrl"],
        productCompanyId: json["productCompanyId"],
        qty: json["qty"],
        price: json["price"],
        discount: json["discount"],
        total: json["total"],
        subTotal: json["subTotal"],
        companyName: json["companyName"],
    );
    
    @override
    List<Object?> get props => [
      id,
      orderId,
      productId,
      productName,
      productCategoryName,
      productUnitMeasurementName,
      productMainPhotoUrl,
      productCompanyId,
      qty,
      price,
      discount,
      total,
      subTotal,
      companyName,
    ];
}

class ShippingRangeCalculation {
    final int? quantity;
    final int? quantityProducts;
    final double? price;
    final ShippingRange? shippingRange;
    final String? shippingRangeId;

    ShippingRangeCalculation({
        this.quantity,
        this.quantityProducts,
        this.price,
        this.shippingRange,
        this.shippingRangeId,
    });

    ShippingRangeCalculation copyWith({
        int? quantity,
        int? quantityProducts,
        double? price,
        ShippingRange? shippingRange,
        String? shippingRangeId,
    }) => 
        ShippingRangeCalculation(
            quantity: quantity ?? this.quantity,
            quantityProducts: quantityProducts ?? this.quantityProducts,
            price: price ?? this.price,
            shippingRange: shippingRange ?? this.shippingRange,
            shippingRangeId: shippingRangeId ?? this.shippingRangeId,
        );

    factory ShippingRangeCalculation.fromJson(Map<String, dynamic> json) => ShippingRangeCalculation(
        quantity: json["quantity"],
        quantityProducts: json["quantityProducts"],
        price: json["price"],
        shippingRange: json["shippingRange"] == null ? null : ShippingRange.fromJson(json["shippingRange"]),
        shippingRangeId: json["shippingRangeId"],
    );
}