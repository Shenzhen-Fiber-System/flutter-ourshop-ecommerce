
import '../pages.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final ShippingAddress selectedShippingAddress = context.select((UsersBloc bloc) => bloc.state.selectedShippingAddress);
    final style = theme.textTheme.bodyMedium?.copyWith(color: AppTheme.palette[600]);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(translations.checkout, style: theme.textTheme.titleLarge,),
      ),
      body: Column(
        children: [
          DefaultShippingAdress(
            size: size, 
            translations: translations, 
            selectedShippingAddress: selectedShippingAddress, 
            style: style, 
            theme: theme
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
        child: ElevatedButton(
          onPressed: () {
            
          }, 
          child: Text('${translations.submit_order} \$${context.watch<ProductsBloc>().selectedCartProductsPrice}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),),
        )
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
                                      context.read<UsersBloc>().addSelectedShippingAddress(context.read<UsersBloc>().state.shippingAddresses.firstWhere((element) => element.id == value));
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