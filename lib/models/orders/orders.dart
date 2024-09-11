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

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}


class Order {
    final String id;
    final String orderNumber;
    final String customerId;
    final dynamic companyId;
    final String customerName;
    final String orderStatus;
    final dynamic shippingAddressId;
    final List<OrderItem> orderItems;
    final List<dynamic> orderStatuses;
    final double subTotal;
    final double discount;
    final double total;
    final DateTime createdAt;

    Order({
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

    Order copyWith({
        String? id,
        String? orderNumber,
        String? customerId,
        dynamic companyId,
        String? customerName,
        String? orderStatus,
        dynamic shippingAddressId,
        List<OrderItem>? orderItems,
        List<dynamic>? orderStatuses,
        double? subTotal,
        double? discount,
        double? total,
        DateTime? createdAt,
    }) => 
        Order(
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

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderNumber: json["orderNumber"],
        customerId: json["customerId"],
        companyId: json["companyId"],
        customerName: json["customerName"],
        orderStatus: json["orderStatus"],
        shippingAddressId: json["shippingAddressId"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
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
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderStatuses": List<dynamic>.from(orderStatuses.map((x) => x)),
        "subTotal": subTotal,
        "discount": discount,
        "total": total,
        "createdAt": createdAt.toIso8601String(),
    };
}

class OrderItem extends Equatable {
    final String id;
    final String orderId;
    final String productId;
    final String productName;
    final String productCategoryName;
    final String productUnitMeasurementName;
    final String productMainPhotoUrl;
    final String productCompanyId;
    final double qty;
    final double price;
    final double discount;
    final double total;
    final double subTotal;
    final String companyName;

    const OrderItem({
        required this.id,
        required this.orderId,
        required this.productId,
        required this.productName,
        required this.productCategoryName,
        required this.productUnitMeasurementName,
        required this.productMainPhotoUrl,
        required this.productCompanyId,
        required this.qty,
        required this.price,
        required this.discount,
        required this.total,
        required this.subTotal,
        required this.companyName,
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

    Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "productId": productId,
        "productName": productName,
        "productCategoryName": productCategoryName,
        "productUnitMeasurementName": productUnitMeasurementName,
        "productMainPhotoUrl": productMainPhotoUrl,
        "productCompanyId": productCompanyId,
        "qty": qty,
        "price": price,
        "discount": discount,
        "total": total,
        "subTotal": subTotal,
        "companyName": companyName,
    };
    
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