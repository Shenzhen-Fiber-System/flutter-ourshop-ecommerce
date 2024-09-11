part of 'orders_bloc.dart';

enum OrdersStatus { initial, loading, loaded, error, loadingMore }

class OrdersState extends Equatable {
  final List<FilteredOrders> adminOrders;
  final OrdersStatus ordersStatus;
  final int currentPage;
  final int totalPages;
  final bool hasMore;
  final List<FilteredOrders> filteredAdminOrders;
  final bool isFiltering;

  const OrdersState({
    this.adminOrders = const [],
    this.ordersStatus = OrdersStatus.initial,
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasMore = true,
    this.filteredAdminOrders = const [],
    this.isFiltering = false,
  });

  OrdersState copyWith({
    List<FilteredOrders>? adminOrders,
    OrdersStatus? ordersStatus,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    List<FilteredOrders>? filteredAdminOrders,
    bool? isFiltering,
  }) {
    return OrdersState(
      adminOrders: adminOrders ?? this.adminOrders,
      ordersStatus: ordersStatus ?? this.ordersStatus,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMore: hasMore ?? this.hasMore,
      filteredAdminOrders: filteredAdminOrders ?? this.filteredAdminOrders,
      isFiltering: isFiltering ?? this.isFiltering,
    );
  }

  @override
  List<Object> get props => [
    adminOrders,
    ordersStatus,
    currentPage,
    totalPages,
    hasMore,
    filteredAdminOrders,
    isFiltering,
  ];
}
