


import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts({super.key});

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {


  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    fetchAdminProducts();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void fetchAdminProducts() {
    context.read<ProductsBloc>().add(AddAdminProductsEvent(
        uuid: context.read<UsersBloc>().state.loggedUser.companyId, 
        page: 1
      )
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
        context.read<ProductsBloc>().add(AddAdminProductsEvent(
            uuid: context.read<UsersBloc>().state.loggedUser.companyId, 
            page: context.read<ProductsBloc>().state.currentPage + 1
          )
        );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle style = theme.textTheme.bodyLarge!.copyWith(color: Colors.black);
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        height: size.height,
        width: size.width,
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {

            if (state.productsStates == ProductsStates.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (state.productsStates == ProductsStates.error) {
              return Center(child: Text(translations.error, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black)));
            }

            if (state.adminProducts.isEmpty) {
              return Center(child: Text(translations.no_products_found, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black)));
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasMore
                ? state.adminProducts.length + 1
                : state.adminProducts.length,
              itemBuilder: (context, index) {
                if (index >= state.adminProducts.length && state.hasMore) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                }
                final FilteredProduct product = state.adminProducts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: Text((index + 1).toString(), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
                      ),
                      Expanded(
                        child: ListTile(
                          onTap: () => context.push('/admin/option/products/detail', extra: product),
                          title: Row(
                            children: [
                              Expanded(child: Text(Helpers.truncateText(product.name, 20), style: style.copyWith(fontSize: 12))),
                              const SizedBox(width: 5.0,),
                              Expanded(child: Text(Helpers.truncateText(product.brandName, 12), style: style.copyWith(fontSize: 12))),
                            ],
                          ),
                          subtitle: Text(product.modelNumber, style: style.copyWith(fontSize: 12)),
                          trailing: IconButton(
                            onPressed: () {
                              DeleteProductDialog(
                                productName: product.name
                              ).showAlertDialog(
                                context, 
                                AppLocalizations.of(context)!, 
                                theme
                              ).then((value) {
                                if (value == true) {
                                  context.read<ProductsBloc>().add(DeleteAdminProductEvent(productId: product.id));
                                }
                              });
                              
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}