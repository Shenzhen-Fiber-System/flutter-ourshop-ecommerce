
import 'dart:developer';
import '../pages.dart';

enum CheckOutMode{
  order_detail,
  checkout
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  final ValueNotifier<String> _selectedCountry = ValueNotifier<String>('');

  final ValueNotifier<String> _selectedCountryId = ValueNotifier<String>('');

  final ValueNotifier<bool> emitOrder = ValueNotifier<bool>(false);


  @override
  void initState() {
    super.initState();
    context.read<CountryBloc>().add(const AddCountriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    Widget spacer = const SizedBox(height: 10.0,);
    // final ShippingAddress selectedShippingAddress = context.select((UsersBloc bloc) => bloc.state.selectedShippingAddress);
    // final TextStyle? style = theme.textTheme.bodyMedium?.copyWith(color: AppTheme.palette[600]);
    final LoggedUser loggedUser = context.watch<UsersBloc>().state.loggedUser;
    return ValueListenableBuilder<bool>(
      valueListenable: emitOrder,
      builder: (BuildContext context, value, Widget? child) {
        if(value){
          return const OrderDetails();
        }
        return child!;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(translations.checkout, style: theme.textTheme.titleLarge,),
        ),
        body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(translations.client_information, style: theme.textTheme.titleLarge,)
                ),
                spacer,
                FormBuilderTextField(
                  name: "name",
                  readOnly: true,
                  initialValue: '${loggedUser.name} ${loggedUser.lastName}',
                  decoration: InputDecoration(
                    labelText: translations.name,
                    hintText: translations.name
                  ),
                ),
                // spacer,
                // ValueListenableBuilder<String>(
                //   valueListenable: _selectedCountry,
                //   builder: (context, value, child) {
                //     return FormBuilderTextField(
                //       name: "country",
                //       readOnly: true,
                //       initialValue: value,
                //       decoration: InputDecoration(
                //         labelText: translations.country,
                //         hintText: translations.country
                //       ),
                //     );
                //   },
                // ),
                spacer,
                FormBuilderTextField(
                  name: "email",
                  readOnly: true,
                  initialValue: loggedUser.email,
                  decoration: InputDecoration(
                    labelText: translations.email,
                    hintText: translations.email
                  ),
                ),
                spacer,
                FormBuilderTextField(
                  name: "phone",
                  readOnly: true,
                  initialValue: loggedUser.userPhoneNumberCode + loggedUser.userPhoneNumber,
                  decoration: InputDecoration(
                    labelText: translations.phone,
                    hintText: translations.phone
                  ),
                ),
                spacer,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(translations.shipping_information, style: theme.textTheme.titleLarge,),
                ),
                spacer,
                Autocomplete(
                  displayStringForOption: (country) => country.name,
                  initialValue: TextEditingValue.empty,
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<Country>.empty();
                    }
                    final List<Country> currencies = List.from(context.read<CountryBloc>().state.countries);
                    return currencies.where((element) => (element.name.trim().toLowerCase().startsWith(textEditingValue.text) || element.iso3.trim().toLowerCase().startsWith(textEditingValue.text))).toList();
                  }, 
                  optionsViewBuilder: (context, onSelected, options) {
                    return Material(
                      elevation: 4.0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Country option = options.toList()[index];
                          return ListTile(
                            selected: false,
                            tileColor: Colors.white,
                            shape: theme.listTileTheme.copyWith(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))
                            ).shape,
                            title: Text(option.name, style: theme.textTheme.titleMedium,),
                            trailing: Text(option.iso3, style: theme.textTheme.labelLarge,),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage('${dotenv.env['FLAG_URL']}${option.flagUrl}'),
                            ),
                            onTap: () => onSelected(option),
                          );
                        }, separatorBuilder: (BuildContext context, int index)  => Divider(
                            height: 0.0,
                            indent: 15.0,
                            endIndent: 15.0,
                            color: Colors.grey.shade300,
                          )
                      ),
                    );
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onFieldSubmitted: (value) => onFieldSubmitted(),
                      decoration: InputDecoration(
                        labelText: translations.country,
                        hintText: translations.country
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required()
                      ]),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    );
                  },
                  onSelected: (country) async {
                    log('coutnry selected: ${country.name}');
                    _selectedCountry.value = country.name;
                    _selectedCountryId.value = country.id;

                    // final data = {
                    // "countryId": "",
                    // "products": [
            
                    //     ]
                    // };
                    // data['countryId'] = _selectedCountryId.value;
                    // data['products'] = context.read<ProductsBloc>().state.cartProducts.map((e) => {
                    //   'productId': e.id,
                    //   'qty': e.quantity,
                    //   'price': e.unitPrice
                    // }).toList();

                    // log('previous datda: $data');

                    // final cShippingRate = await locator<ProductService>().calculateshippingRate(data);


                  },
                ),
                spacer,
                FormBuilderTextField(
                  name: "address",
                  decoration: InputDecoration(
                    labelText: translations.address,
                    hintText: translations.address
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required()
                  ]),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Expanded(
                  child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: state.cartProducts.length,
                        itemBuilder: (context, index) {
                          final FilteredProduct product = state.cartProducts[index];
                          return CartCard(
                            product: product
                          );
                        },
                      );
                    },
                  )
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.1,
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, -2),
                blurRadius: 6.0
              )
            ]
          ),
          child: BlocConsumer<ProductsBloc, ProductsState>(
            listenWhen: (previous, current) => current.productsStates == ProductsStates.calculated && current.calculateShippingRangeresponse.success == true,
            listener: (context, state) {
              if(state.productsStates == ProductsStates.calculated && state.calculateShippingRangeresponse.success == true){
                emitOrder.value = true;
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: state.cartProducts.isEmpty || state.productsStates == ProductsStates.calculating ? null : () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final data = {
                        "countryId": "",
                        "products": []
                    };
                    data['countryId'] = _selectedCountryId.value;
                    data['products'] = context.read<ProductsBloc>().state.cartProducts.map((e) => {
                      'productId': e.id,
                      'quantity': e.quantity
                    }).toList();
                    context.read<ProductsBloc>().add(CalculateShippingRateEvent(body: data));      
                  }
                }, 
                child:state.productsStates == ProductsStates.calculating ? const CircularProgressIndicator.adaptive() : Text(translations.submit_order, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),),
              );
            },
          )
        ),
      ),
    );
  }
}

class DefaultShippingAdress extends StatelessWidget {
  const DefaultShippingAdress({
    super.key,
    required this.size,
    required this.translations,
    required this.selectedShippingAddress,
    required this.style,
    required this.theme,
  });

  final Size size;
  final AppLocalizations translations;
  final ShippingAddress selectedShippingAddress;
  final TextStyle? style;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.all(8.0),
      height: size.height * 0.20,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.amber,
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey.shade400, width: 2),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                Icon(Icons.location_on ,color: AppTheme.palette[700],)
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${ Helpers.truncateText(translations.name, 60)}: ${selectedShippingAddress.fullName}", style: style,),
                  Text("${ Helpers.truncateText(translations.address, 60)}: ${selectedShippingAddress.address}", style: style,),
                  Text("${ Helpers.truncateText(translations.city, 60)}: ${selectedShippingAddress.state}", style: style,),
                  Text("${ Helpers.truncateText(translations.country, 60)}: ${selectedShippingAddress.country}", style: style,),
                  Text("${ Helpers.truncateText(translations.zip_code, 60)}: ${selectedShippingAddress.postalCode}", style: style,),
                  Text("${ Helpers.truncateText(translations.phone, 60)}: ${selectedShippingAddress.phoneNumber}", style: style,),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context, 
                    builder: (context) {
                      return SizedBox(
                        height: size.height * 0.5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Text(translations.choose_shipping_address, style: theme.textTheme.titleLarge,),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: context.read<UsersBloc>().state.shippingAddresses.length,
                                itemBuilder: (context, index) {
                                  final ShippingAddress address = context.read<UsersBloc>().state.shippingAddresses[index];
                                  return RadioListTile(
                                    selected: false,
                                    tileColor: Colors.white,
                                    shape: theme.listTileTheme.copyWith(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))
                                    ).shape,
                                    secondary: IconButton(
                                      onPressed: () {
                                        
                                      }, 
                                      icon: const  Icon(Icons.edit, size: 15, color: Colors.grey,)
                                    ),
                                    title: Text(address.fullName),
                                    subtitle: Text('${address.address}, ${address.municipality}, ${address.state}, ${address.country}', style: TextStyle(color: Colors.grey.shade500, fontSize: 10.0)), 
                                    value: address.id, 
                                    groupValue: context.watch<UsersBloc>().state.selectedShippingAddress.id, 
                                    onChanged: (value) {
                                      // context.read<UsersBloc>().addSelectedShippingAddress(context.read<UsersBloc>().state.shippingAddresses.firstWhere((element) => element.id == value));
                                    } 
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }, 
                icon: const Icon(Icons.arrow_right)
              )
            ],
          )
        ],
      ),
    );
  }
}


class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    Widget spacer = const SizedBox(height: 10.0,);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(translations.order_detail, style: theme.textTheme.titleLarge,),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.55,
              width: size.width,
              child: ListView.builder(
                itemCount: context.watch<ProductsBloc>().state.cartProducts.length,
                itemBuilder: (context, index) {
                  final FilteredProduct product = context.watch<ProductsBloc>().state.cartProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(0, 2),
                            blurRadius: 6.0
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.20,
                            width: size.width,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                              child: ProductImage(
                                product: product,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(child: Text(translations.product_name(product.name), style: theme.textTheme.titleMedium,))
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(child: Text(translations.product_quantity(product.quantity), style: theme.textTheme.titleMedium,))),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(child: Text(translations.product_unit_price('\$${product.unitPrice}'), style: theme.textTheme.titleMedium,))),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(child: Text(translations.product_sub_total_price('\$${product.quantity * product.unitPrice!}'), style: theme.textTheme.titleMedium,))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
             child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              width: size.width,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(translations.order_cost, style: theme.textTheme.titleLarge,)
                  ),
                  spacer,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(translations.sub_total(': \$${context.watch<ProductsBloc>().subtotal}'), style: theme.textTheme.titleMedium,)
                  ),
                  spacer,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(translations.order_shipping_cost(': \$${context.read<ProductsBloc>().calculatedShipingRate}'), style: theme.textTheme.titleMedium,)
                  ),
                  spacer,
                  const Divider(),
                  spacer,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(translations.total_order(': \$${context.watch<ProductsBloc>().subtotal + context.read<ProductsBloc>().calculatedShipingRate}'), style: theme.textTheme.titleLarge,)
                  ),
                  const Spacer(),
                  SizedBox(
                    width: size.width,
                    child: BlocConsumer<OrdersBloc, OrdersState>(
                      listenWhen: (previous, current) => current.ordersStatus == OrdersStatus.orderSubmitted,
                      listener: (BuildContext context, OrdersState state) {
                        if (state.ordersStatus == OrdersStatus.orderSubmitted) {
                          context.read<ProductsBloc>().add(const ClearCart());
                          SuccessToast(
                            title: translations.order_created,
                            titleStyle: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                            backgroundColor: Colors.green,
                            autoCloseDuration: const Duration(seconds: 2),
                            onAutoCompleted: (_) {
                              context.go('/home');
                            },
                          ).showToast(context);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.ordersStatus == OrdersStatus.submittingOrder || context.watch<UsersBloc>().state.status == UserStatus.paying ? null : () {
                            context.read<UsersBloc>().add(MakeStripePaymentEvent(
                              stripePayment: StripePayment(
                                amount: (context.read<ProductsBloc>().subtotal * 100.00).toInt(),
                                currency: 'usd'
                              ))
                            );
                          }, 
                          child: state.ordersStatus == OrdersStatus.submittingOrder || context.watch<UsersBloc>().state.status == UserStatus.paying ? const Center(child: CircularProgressIndicator.adaptive(),) : Text(translations.submit_order, style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),),
                        );
                      },
                    ),
                  )
                ],
              )
             ), 
            ),
          ],
        ),
      )
    );
  }
}