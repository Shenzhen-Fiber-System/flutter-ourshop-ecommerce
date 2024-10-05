import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key, required this.order});
  final FilteredOrders order;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> with TickerProviderStateMixin {

  final ValueNotifier<bool> _editMode = ValueNotifier<bool>(false);
  final List<String> tabs = ['Articulos', 'Estados y comentarios'];
  final List<String> status = ['Pendiente', 'Enviado', 'Entregado', 'Cancelado', 'Pagado'];

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _editMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final TextStyle style = theme.textTheme.bodyLarge!.copyWith(color: Colors.black);
    final Size size = MediaQuery.of(context).size;
    const Widget spacer = SizedBox(height: 10);

    return Scaffold(
      appBar: AppBar(
        title: Text('${translations.order} #${widget.order.orderNumber}'),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => _editMode.value = !_editMode.value, 
            icon: const Icon(Icons.edit)
          )
        ],
        bottom: const PreferredSize(
          preferredSize:  Size.fromHeight(5.0),
          child: Divider(indent: 30,endIndent: 30,)
        )
      ),
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: ValueListenableBuilder(
          valueListenable: _editMode,
          builder: (BuildContext context, value, Widget? child) {

            if (value){
              final TextStyle style = theme.textTheme.bodyMedium!.copyWith(color: Colors.black);
              return FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: FormBuilderTextField(
                        name: "client-name",
                        style: style,
                        initialValue: widget.order.customerName,
                        decoration: InputDecoration(
                          labelText: translations.client_name,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: FormBuilderTextField(
                        name: "status",
                        style: style,
                        initialValue: widget.order.orderStatus,
                        decoration: InputDecoration(
                          labelText: translations.status(''),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: FormBuilderTextField(
                        name: "total",
                        style: style,
                        initialValue: widget.order.total.toString(),
                        decoration: InputDecoration(
                          labelText: translations.total,
                        ),
                      ),
                    ),
                    DefaultTabController(
                      length: tabs.length, 
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            tabAlignment: TabAlignment.center,
                            tabs: [
                              Tab(text: translations.articles),
                              Tab(text: translations.state_comments),
                            ],
                          ),
                        ],
                      )
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: FutureBuilder<Order>(
                              future: context.read<OrdersBloc>().getOrderById(widget.order.id),
                              builder: (BuildContext context, AsyncSnapshot<Order> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator.adaptive());
                                  if (snapshot.hasError) return const Center(child: Text('Error'));
                                  return ListView.builder(
                                    itemCount: snapshot.data!.orderItems?.length,
                                    itemBuilder: (context, index) {
                                      final OrderItem item = snapshot.data!.orderItems![index];
                                      return _Article(
                                        size: size, 
                                        item: item, 
                                        style: style, 
                                        translations: translations
                                      );
                                    },
                                  );
                                },
                            ),
                          ),
                          Container(
                            height: size.height,
                            width: size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: FormBuilderDropdown(
                                    name: "order-status",
                                    decoration: InputDecoration(
                                      labelText: translations.order_status,
                                      hintText: translations.order_status,
                                    ), items: status.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: FormBuilderTextField(
                                    name: "comentario",
                                    decoration: InputDecoration(
                                      labelText: translations.comments,
                                      hintText: translations.comments,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(translations.order_status_history, style: style.copyWith(fontSize: 18, fontWeight: FontWeight.w500),),
                                ),
                                Expanded(
                                  child: FutureBuilder<Order>(
                                    future: context.read<OrdersBloc>().getOrderById(widget.order.id),
                                    builder: (BuildContext context, AsyncSnapshot<Order> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator.adaptive());
                                        if (snapshot.hasError) return  Center(child: Text('Error', style: style,));
                                        return ListView.builder(
                                          itemCount: snapshot.data!.orderItems?.length,
                                          itemBuilder: (context, index) {
                                            final OrderItem item = snapshot.data!.orderItems![index];
                                            return _Article(
                                              size: size, 
                                              item: item, 
                                              style: style, 
                                              translations: translations
                                            );
                                          },
                                        );
                                     },
                                  ),
                                ),                         
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              );
            }
            return child!;
            
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(translations.client(widget.order.customerName), style: style ,),
              spacer,
              Text(translations.status(widget.order.orderStatus), style: style),
              spacer,
              // Text(translations.date(widget.order.createdAt), style: style),
              // spacer,
              Text(translations.total_order('\$${widget.order.total}'), style: style.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Article extends StatelessWidget {
  const _Article({
    required this.size,
    required this.item,
    required this.style,
    required this.translations,
  });

  final Size size;
  final OrderItem item;
  final TextStyle style;
  final AppLocalizations translations;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 0),
          )
        ]
      ),
      width: size.width,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
            child: 
            item.productMainPhotoUrl != null ?
            CachedNetworkImage(
              imageUrl: '${dotenv.env['PRODUCT_URL']}${item.productMainPhotoUrl}',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ) : 
            SizedBox(
              width: size.width * 0.25,
              child: Column(
                children: [
                  const Icon(Icons.image_not_supported, size: 50, color: Colors.grey,),
                  FittedBox(
                    child: Text(translations.no_image, style: style.copyWith(color: Colors.grey),),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 5.0),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Helpers.truncateText(item.productName!, 25), style: style, overflow: TextOverflow.ellipsis,),
                  Text(translations.unit_price(item.price!), style: style),
                  Text(translations.discount(item.discount!), style: style),
                  Text(translations.sub_total(item.subTotal!), style: style),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}