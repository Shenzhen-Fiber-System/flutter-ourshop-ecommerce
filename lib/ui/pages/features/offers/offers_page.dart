import '../../pages.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(listener);
    fetchOfferProducts();
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    _scrollController.dispose();
    super.dispose();
  }

  void listener() {
    final double threshold = _scrollController.position.maxScrollExtent * 0.1;
    if (_scrollController.position.pixels >= threshold && 
        context.read<ProductsBloc>().state.hasMore && 
        context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
      fetchOfferProducts();
    }
  }

  void fetchOfferProducts() {
    context.read<ProductsBloc>().add(AddOfferProductEvent(
        page: context.read<ProductsBloc>().state.offerProductsCurrentPage + 1,
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final TextStyle? style = theme.textTheme.bodyMedium?.copyWith(color: Colors.black);
  
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: size.height,
      width: size.width,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        buildWhen: (previous, current) => previous.offerProducts != current.offerProducts || previous.productsStates != current.productsStates,
        builder: (context, state) {
          if (state.productsStates == ProductsStates.loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.productsStates == ProductsStates.error) {
            return Center(child: Text(translations.error, style: style,));
          }

          if (state.offerProducts.isEmpty) {
            return Center(child: Text(translations.no_results_found, style: style,));
          }

          return GridView.builder(
            controller: _scrollController,
              itemCount:state.hasMore
                      ? state.offerProducts.length + 1
                      : state.offerProducts.length,
              itemBuilder: (context, index) {
                if (index == state.offerProducts.length) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                }
                if (state.offerProducts.isEmpty) {
                  return Center(child: Text(translations.no_results_found, style: style,));
                }
                final FilteredOfferProduct product = state.offerProducts[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ProductImage(product: product.product!),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Center(child: Text('-${product.getDiscountType() == DiscountType.FIXED ? '\$${product.discountValue}' : '${product.discountValue}%' }', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),)),
                            ),
                          ),

                        ]
                      ),
                      Text(Helpers.truncateText(product.product!.name, 18),style: theme.textTheme.labelMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w400),),
                      const SizedBox(height: 5.0),
                      if (product.product!.productReviewInfo?.ratingAvg != null) 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(product.product!.productReviewInfo!.ratingAvg.toStringAsFixed(1), style: theme.textTheme.labelMedium?.copyWith(color: Colors.black),),
                            ),
                            RaitingBarWidget(product: product.product!),
                          ],
                        )
                      else const SizedBox.shrink(),
                      if (product.product!.productReviewInfo?.summary != null && product.product!.productReviewInfo!.summary!.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(translations.product_ratings(product.product!.productReviewInfo!.reviewCount ?? 0.0), style: theme.textTheme.bodySmall,),
                          ],
                        )
                      else const SizedBox.shrink(),
                      const SizedBox(height: 2.0),
                      const SendAnimatedWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Text(
                              product.product!.unitPrice != null ? '\$${product.product!.unitPrice?.toStringAsFixed(2)}' : ('\$${product.product!.fboPriceStart?.toStringAsFixed(2)}-\$${product.product!.fboPriceEnd?.toStringAsFixed(2)}'),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.grey, fontWeight: FontWeight.w600,
                                decoration: product.product!.unitPrice != null ? TextDecoration.lineThrough : TextDecoration.none
                              ),
                            ),
                            const SizedBox(width: 5.0,),
                            Text('\$${product.newprice.toStringAsFixed(2)}', style: theme.textTheme.labelMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),),
                            const Spacer(),
                            if (product.product!.unitPrice != null)
                              GestureDetector(
                                onTap: () => context.read<ProductsBloc>().add(AddCartProductEvent(product: product.product!)),
                                child:  CircleAvatar(
                                  maxRadius: 18,
                                  backgroundColor: AppTheme.palette[1000],
                                  child: const Icon(
                                    Icons.add_shopping_cart_rounded,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              )
                          ],
                          
                        ),
                      ),
                    ]
                  )
                );
              }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6
              ),
            );
        },
      )
    );
  }
}