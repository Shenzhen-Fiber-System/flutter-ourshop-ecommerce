import '../../pages.dart';

class SelectedProductPage extends StatelessWidget {
  const SelectedProductPage({super.key, required this.product});

  final FilteredProduct product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;
    const Widget spacer = SizedBox(width: 10.0,);

    return BlocListener<ProductsBloc, ProductsState>(
      listenWhen: (previous, current) =>  current.cartProducts.length > previous.cartProducts.length ,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text(translations.product_added_to_cart),
            actions: [
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: Text(translations.close, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),
              )
            ],
          )
        );
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              style: theme.iconButtonTheme.style?.copyWith(
                shadowColor: WidgetStatePropertyAll(Colors.grey.shade300),
              ),
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop()
            ),
            title: Text(translations.detail_product, style: theme.textTheme.titleLarge,),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _Image(
                  size: size, 
                  product: product, 
                  theme: theme, 
                  translations: translations,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(  // Coloca Expanded directamente aquí
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          product.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: const Color(0xff5d5f61),
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: BlocBuilder<ProductsBloc, ProductsState>(
                        builder: (context, state) {
                          return Icon(
                            state.favoriteProducts.contains(product) ? Icons.favorite : Icons.favorite_border_outlined, 
                            color: state.favoriteProducts.contains(product) ?  Colors.red : Colors.grey.shade400,
                          );
                        },
                      ),
                      // onPressed: () => context.read<ProductsBloc>().addFavoriteProduct(product),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 5.0,),
                if (product.productReviewInfo?.ratingAvg != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 10.0),
                        child: Text(product.productReviewInfo!.ratingAvg.toStringAsFixed(1), style: theme.textTheme.labelLarge?.copyWith(color: Colors.black),),
                      ),
                      RaitingBarWidget(product: product),
                    ],
                  )
                else const SizedBox.shrink(),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text('USD ${product.unitPrice != null ? '\$${product.unitPrice?.toStringAsFixed(2)}' : ('\$${product.fboPriceStart?.toStringAsFixed(2)}-\$${product.fboPriceEnd?.toStringAsFixed(2)}')}', style: theme.textTheme.titleMedium?.copyWith(color: const Color(0xff5d5f61), fontWeight: FontWeight.w600),),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Chip(
                            //     visualDensity: VisualDensity.compact,
                            //     side: BorderSide.none,
                            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            //     padding: const EdgeInsets.all(0),
                            //     label: Text('6% off', style: theme.textTheme.labelMedium?.copyWith(color:Colors.white),), 
                            //     backgroundColor: AppTheme.palette[900],
                            //   ),
                            // ),
                          ],
                        ),
                        // Text('USD \$${product.unitPrice != null ? '\$${product.unitPrice?.toStringAsFixed(2)}' : ('\$${product.fboPriceStart?.toStringAsFixed(2)}-\$${product.fboPriceEnd?.toStringAsFixed(2)}')}', style: theme.textTheme.titleSmall?.copyWith(color: Colors.grey.shade400, decoration: TextDecoration.lineThrough),),
                        
                        
                      ],
                    ),
                  ],
                ),
                Section(
                  title: translations.specifications, 
                  content: product.name,
                  theme: theme, 
                  translations: translations,
                  type: SectionType.text,
                ),
                Section(
                  title: translations.details, 
                  content: product.name,
                  theme: theme, 
                  translations: translations,
                  type: SectionType.text,
                ),
                Section(
                  title: translations.videos,
                  content: '',
                  theme: theme, 
                  translations: translations,
                  type: SectionType.videos,
                  product: product,
                ),
                Section(
                  title: translations.comments,
                  content: '',
                  theme: theme, 
                  translations: translations,
                  product: product,
                  type: SectionType.custom,
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (product.unitPrice == null) {
                    return SizedBox(
                      width: size.width * 0.9,
                      child: ElevatedButton(
                        style: theme.elevatedButtonTheme.style?.copyWith(
                          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.disabled)) {
                              return Colors.grey.shade400;
                            }
                            return Colors.green;
                          }),
                        ),
                        onPressed: () => ContactSellerDialog(product: product).showAlertDialog(context, translations, theme),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.support_agent_outlined, color: Colors.white, size: 25.0,),
                            spacer,
                            Text(translations.contact_seller, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),),
                          ],
                        ),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: 
                    [
                      SizedBox(
                        width: size.width * 0.4,
                        child: OutlinedButton(
                          style: theme.outlinedButtonTheme.style?.copyWith(
                            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
                          ),
                          onPressed: () => context.read<ProductsBloc>().add(AddCartProductEvent(product: product)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag_outlined, color: AppTheme.palette[1000], size: 13.0,),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(translations.add_to_cart, style: theme.textTheme.labelMedium?.copyWith(color: AppTheme.palette[1000]),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: size.width * 0.4,
                      //   child: ElevatedButton(
                      //     onPressed: state.cartProducts.isEmpty ? null : () => context.push('/checkout'),
                      //     child: Text(translations.checkout, style: theme.textTheme.labelMedium),
                      //   ),
                      // ),
                      SizedBox(
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          style: theme.elevatedButtonTheme.style?.copyWith(
                            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors.grey.shade400;
                              }
                              return Colors.green;
                            }),
                          ),
                          onPressed: () => ContactSellerDialog(product: product).showAlertDialog(context, translations, theme),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.support_agent_outlined, color: Colors.white, size: 13.0,),
                              spacer,
                              Text(Helpers.truncateText(translations.contact_seller, 12), style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
    );
  }
}

class _Image extends StatelessWidget {
  _Image({
    required this.size,
    required this.product, 
    required this.theme, 
    required this.translations,
  });

  final Size size;
  final FilteredProduct product;
  final ThemeData theme;
  final AppLocalizations translations;

  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {

    if (product.productPhotos.isEmpty) Center(child: Icon(Icons.image_not_supported, size: 100.0, color: Colors.grey.shade500,),);

    return SizedBox(
      height: size.height * 0.4,
      width: size.width,
      child: Column(
        children: [
          Expanded(
            child:
             product.productPhotos.isNotEmpty ?
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: size.height * 0.4,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    _currentPage.value = index;
                  },
                ),
                items: product.productPhotos.map((photo) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ProductImage(
                        product: product, 
                      ),
                    ),
                  );
                }).toList(),
              )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported, size: 100.0, color: Colors.grey.shade500,),
                Text(translations.no_image, style: theme.textTheme.labelMedium?.copyWith(color: Colors.grey.shade500)),
              ],
            )
          ),
          if (product.productPhotos.isNotEmpty)
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: product.productPhotos.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: ValueListenableBuilder(
                          valueListenable: _currentPage,
                          builder: (BuildContext context, value,  child) {
                            return Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value == entry.key ? AppTheme.palette[1000] : AppTheme.palette[700]
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(right: 10.0),
                    height: 30.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: AppTheme.palette[800],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: _currentPage,
                        builder: (BuildContext context, value, Widget? child) {
                          return Text('${value + 1}/${product.productPhotos.length}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 10.0, color: Colors.white),);
                        },
                      )
                    ),
                  )
                ),
              ]
            )
          else const SizedBox.shrink()
        ],
      )
    );
  }
}