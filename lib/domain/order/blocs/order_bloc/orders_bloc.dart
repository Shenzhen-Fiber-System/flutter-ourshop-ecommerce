import 'dart:developer';

import '../../../../ui/pages/pages.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderService _orderService;
  OrdersBloc(OrderService service) : 
   _orderService = service,
  super(const OrdersState()) {
    on<AddAdminOrdersEvent>((event, emit) => emit(state.copyWith(adminOrders: event.adminOrders, currentPage: event.page, totalPages: event.totalPages)));
    on<AddOrdersStatusEvent>((event, emit) => emit(state.copyWith(ordersStatus: event.ordersStatus, hasMore: event.hasMore)));
    on<AddFilteredAdminOrdersEvent>((event, emit) => emit(state.copyWith(filteredAdminOrders: event.filteredAdminOrders)));
    on<FilterAdminOrdersEvent>((event, emit) {
      final List<FilteredOrders> filteredAdminOrders = state.filteredAdminOrders.where((element) => element.customerName.toLowerCase().contains(event.searchString.toLowerCase())).toList();
      log('filteredAdminOrders: $filteredAdminOrders');
      if (filteredAdminOrders.isNotEmpty) {
        emit(state.copyWith(filteredAdminOrders: filteredAdminOrders, isFiltering: false));
      } else {
        emit(state.copyWith(filteredAdminOrders: state.adminOrders, isFiltering: false));
      }
    });

    on<AddOrdersByUserEvent>((event,emit) async {
      try {
        emit(state.copyWith(ordersStatus: OrdersStatus.loading));
        // 
        emit(state.copyWith(
           
            ordersStatus: OrdersStatus.loaded
          )
        );
      } catch (e) {
        log('e: $e');
      }
    });

    on<NewOrderEvent>((event,emit) async {
      try { 
        emit(state.copyWith(ordersStatus: OrdersStatus.submittingOrder));
        final dynamic response = await _orderService.addNewOrder(event.data);
        if (response is OrderResponse) {
          emit(state.copyWith(
            ordersStatus: OrdersStatus.orderSubmitted
          ));
        }
        emit(state.copyWith(ordersStatus: OrdersStatus.initial));
      } catch (e) {
        log('e: $e');
      }
    });
  }


  Future<void> getFilteredAdminOrders(int page) async {
  if (page == 1) {
    add(const AddOrdersStatusEvent(ordersStatus: OrdersStatus.loading));
  } else {
    add(const AddOrdersStatusEvent(ordersStatus: OrdersStatus.loadingMore));
  }

  log('company id: ${locator<UsersBloc>().state.loggedUser.companyId}');

  final filteredParameters = {
    "uuids": [
      {
        "fieldName": "orderItems.product.company.id",
        "value": locator<UsersBloc>().state.loggedUser.companyId
      }
    ],
    "searchFields": [],
    "sortOrders": [],
    "page": page,
    "pageSize": 10,
    "searchString": ""
  };

  try {
    // if (!state.hasMore) return;
    final response = await _orderService.getFilteredAdminOrders(filteredParameters);
    if (response is FilteredData) { 

      final List<FilteredOrders> updatedOrders = List<FilteredOrders>.from(state.adminOrders);
      updatedOrders.addAll(response.content as List<FilteredOrders>);

      // add the current admin orders in filteredAdminOrders
      add(AddFilteredAdminOrdersEvent(filteredAdminOrders: updatedOrders));

      add(AddAdminOrdersEvent(
        adminOrders: updatedOrders ,
        page: response.page,
        totalPages: response.totalPages,
      ));
      final hasMore = response.page < response.totalPages;
      add(AddOrdersStatusEvent(
        ordersStatus: OrdersStatus.loaded,
        hasMore: hasMore,
      ));
    }
  } catch (e) {
    log('e: $e');
    add(const AddOrdersStatusEvent(ordersStatus: OrdersStatus.error));
  }
}

Future<Order> getOrderById(String orderId) async {
  try {
    final response = await _orderService.getOrderbyId(orderId);
    return response;
  } catch (e) {
    log('e: $e');
    throw Exception('Error getting order by id :$e');
  }
}

  void restartState() {
    add(const AddAdminOrdersEvent(adminOrders: [], page: 1, totalPages: 1));
    add(const AddOrdersStatusEvent(ordersStatus: OrdersStatus.initial,hasMore: true,));
  }
}