import '../../../../../pages.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    fetchAdminOrders();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  Future<void> fetchAdminOrders() async {
    await context.read<OrdersBloc>().getFilteredAdminOrders(1);
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && context.read<OrdersBloc>().state.hasMore && context.read<OrdersBloc>().state.ordersStatus != OrdersStatus.loadingMore) {
      if (context.read<OrdersBloc>().state.ordersStatus != OrdersStatus.loadingMore) {
        await context.read<OrdersBloc>().getFilteredAdminOrders(context.read<OrdersBloc>().state.currentPage + 1);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<OrdersBloc>().restartState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state.ordersStatus == OrdersStatus.loading && state.adminOrders.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state.ordersStatus == OrdersStatus.error && state.adminOrders.isEmpty) {
            return Center(child: Text('Error', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)));
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                // Container(
                //   color: Colors.white,
                //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                //   child: FormBuilderTextField(
                //     style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                //     name: translations!.search,
                //     decoration: InputDecoration(
                //       labelText: translations!.search,
                //       prefixIcon: const Icon(Icons.search),
                //     ),
                //     onChanged: (value) {
                //       context.read<OrdersBloc>().add(FilterAdminOrdersEvent(searchString: value!, isFiltering: true));
                //     },
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasMore
                        ? state.filteredAdminOrders.length + 1 // Añade un ítem extra para el indicador de carga
                        : state.filteredAdminOrders.length,
                    itemBuilder: (context, index) {
                      if (index >= state.adminOrders.length && state.hasMore) {
                        return const Center(child: CircularProgressIndicator.adaptive());
                      }
                  
                      final FilteredOrders order = state.adminOrders[index];
                      return Padding(
                        padding: index > 0 ? const EdgeInsets.only(top:10.0) : EdgeInsets.zero,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right:5.0),
                              child: Text((index + 1).toString(), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(order.orderNumber, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
                                subtitle: Text(order.customerName, style: theme.textTheme.bodySmall?.copyWith(color: Colors.black)),
                                onTap: () => context.push('/admin/option/orders/detail', extra: order),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
