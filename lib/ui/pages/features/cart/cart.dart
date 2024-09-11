import '../../pages.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key, 
    this.canBack = false
  });


  final bool canBack;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: canBack ?  IconButton(
          icon: const Icon(Icons.arrow_back),
          // onPressed: () => context.go('/sub-category/${context.read<ProductsBloc>().state.selectedSubCategory.parentCategoryId}'),
          onPressed: () => context.pop(),
        ) : TextButton(
          onPressed: () => context.read<ProductsBloc>().selectedCartProductsCount == 0 ? context.read<ProductsBloc>().selectAllCartProducts() : context.read<ProductsBloc>().deselectAllCartProducts(),
          child: Text('${context.watch<ProductsBloc>().selectedCartProductsCount == 0 ? translations.select_all : translations.deselect_all} ${context.watch<ProductsBloc>().selectedCartProductsCount}', style: theme.textTheme.labelSmall?.copyWith(color: AppTheme.palette[1000]!),)
        ),
        leadingWidth: canBack ? null : 150,
        title: Text(translations.cart, style: theme.textTheme.titleLarge?.copyWith(color: AppTheme.palette[1000]),),
        actions: [
          TextButton(
            child: Text(translations.clear_all, style: theme.textTheme.labelMedium?.copyWith(color: AppTheme.palette[1000]),),
            onPressed: () {
              context.read<ProductsBloc>().add(const ClearCart());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (canBack)
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () => context.read<ProductsBloc>().selectedCartProductsCount == 0 ? context.read<ProductsBloc>().selectAllCartProducts() : context.read<ProductsBloc>().deselectAllCartProducts(),
                child: Text('${context.watch<ProductsBloc>().selectedCartProductsCount == 0 ? translations.select_all : translations.deselect_all} ${context.watch<ProductsBloc>().selectedCartProductsCount}', style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),)
              ),
            )
          else const SizedBox.shrink(),
          Expanded(
            child: SizedBox(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state.cartProducts.isEmpty) {
                    return Center(child: Text(translations.cart_empty, style: theme.textTheme.titleMedium,),);
                  }
                  return ListView.builder(
                    itemCount: state.cartProducts.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(state.cartProducts[index].id),
                        background: const ColoredBox(
                          color: Colors.red, 
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete, color: Colors.white,)
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) {
                          return DeleteProductDialog(productName: state.cartProducts[index].name).showAlertDialog(context, translations, theme)
                          .then((value){
                              if (value != null && value) {
                                context.read<ProductsBloc>().removeCartProduct(state.cartProducts[index]);
                                return Future.value(value);
                              }
                              return Future.value(false);
                            }
                          );
                        },
                        onDismissed: (direction) {
                          context.read<ProductsBloc>().removeCartProduct(state.cartProducts[index]);
                        },
                        child: CartCard(
                          showCheckBox: true,
                          product: state.cartProducts[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: context.read<ProductsBloc>().state.cartProducts.isEmpty || context.read<ProductsBloc>().selectedCartProductsPrice == 0.00 ? null : () => context.push('/checkout'),
                child: Text('${translations.checkout} \$${context.watch<ProductsBloc>().selectedCartProductsPrice}', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),),
              ),
            ),
          )
        ],
      ),
    );
  }
}