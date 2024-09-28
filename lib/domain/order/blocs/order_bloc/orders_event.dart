part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class AddAdminOrdersEvent extends OrdersEvent {
  final List<FilteredOrders> adminOrders;
  final int page;
  final int totalPages;

  const AddAdminOrdersEvent({
    required this.adminOrders,
    required this.page,
    required this.totalPages,
  });

  @override
  List<Object> get props => [adminOrders, page, totalPages];
}

class AddOrdersStatusEvent extends OrdersEvent {
  final OrdersStatus ordersStatus;
  final bool hasMore;

  const AddOrdersStatusEvent({
    required this.ordersStatus,
    this.hasMore = true,
  });

  @override
  List<Object> get props => [ordersStatus, hasMore];
}

class AddFilteredAdminOrdersEvent extends OrdersEvent {
  final List<FilteredOrders> filteredAdminOrders;

  const AddFilteredAdminOrdersEvent({
    required this.filteredAdminOrders,
  });

  @override
  List<Object> get props => [filteredAdminOrders];
}

class FilterAdminOrdersEvent extends OrdersEvent {
  final String searchString;
  final bool isFiltering;

  const FilterAdminOrdersEvent({
    required this.searchString,
    required this.isFiltering,
  });

  @override
  List<Object> get props => [searchString, isFiltering];
}

class AddOrderProductsEvent extends OrdersEvent {
  

  @override
  List<Object> get props => [];
}
