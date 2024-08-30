import '../../pages.dart';

class SelectedProductPage extends StatelessWidget {
  const SelectedProductPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;

    return BlocListener<ProductsBloc, ProductsState>(
      listenWhen: (previous, current) => previous.cartProducts.length != current.cartProducts.length,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            content: Text(translations.product_added_to_cart),
            actions: [
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                child: Text(translations.close, style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),),
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(translations.detail_product, style: theme.textTheme.titleLarge,),
          ),
          body: Column(
            children: [
              _Image(size: size, product: product, theme: theme, translations: translations,),
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
                    onPressed: () => context.read<ProductsBloc>().addFavoriteProduct(product),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text('USD \$${product.unitPrice}', style: theme.textTheme.titleMedium?.copyWith(color: const Color(0xff5d5f61), fontWeight: FontWeight.w500),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Chip(
                              visualDensity: VisualDensity.compact,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              padding: const EdgeInsets.all(0),
                              label: Text('6% off', style: theme.textTheme.labelMedium?.copyWith(color: AppTheme.palette[700]),), 
                              backgroundColor: AppTheme.palette[50],
                            ),
                          ),
                        ],
                      ),
                      Text('USD \$${product.unitPrice}', style: theme.textTheme.titleSmall?.copyWith(color: Colors.grey.shade400, decoration: TextDecoration.lineThrough),),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
          bottomNavigationBar: CustomBottomBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: OutlinedButton(
                      onPressed: () => context.read<ProductsBloc>().addCartProduct(product),
                      child: Row(
                        children: [
                          Icon(Icons.shopping_bag_outlined, color: AppTheme.palette[500], size: 14,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(translations.add_to_cart, style: theme.textTheme.labelMedium?.copyWith(color: AppTheme.palette[500]),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () => context.push('/checkout'),
                      child: Text(translations.checkout, style: theme.textTheme.labelMedium),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

class _Image extends StatefulWidget {
  const _Image({
    required this.size,
    required this.product, 
    required this.theme, 
    required this.translations,
  });

  final Size size;
  final Product product;
  final ThemeData theme;
  final AppLocalizations translations;

  @override
  State<_Image> createState() => _ImageState();
}

class _ImageState extends State<_Image> {

  late PageController _pageController;
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  void listener() {
    _currentPage.value = _pageController.page!.round();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _pageController.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height * 0.4,
      width: widget.size.width,
      child: Column(
        children: [
          Expanded(
            child:
             widget.product.productPhotos.isNotEmpty ?
             PageView.builder(
              controller: _pageController,
              itemCount: widget.product.productPhotos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Hero(
                      tag: widget.product.id,
                      child: Image(
                        image: NetworkImage('${dotenv.env['PRODUCT_URL']}${widget.product.productPhotos[index].photo!.url}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ) 
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported, size: 100.0, color: Colors.grey.shade500,),
                Text(widget.translations.no_image, style: widget.theme.textTheme.labelMedium?.copyWith(color: Colors.grey.shade500)),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Stack(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _currentPage,
                  builder: (BuildContext context, int value, Widget? child) {
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        
                        height: 30,
                        width: 75,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < widget.product.productPhotos.length; i++)
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                    height: 10.0,
                                    width: 10.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: value == i ? AppTheme.palette[500] : AppTheme.palette[300],
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(right: 10.0),
                    height: 30.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: AppTheme.palette[100],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: ValueListenableBuilder(
                        valueListenable: _currentPage,
                        builder: (BuildContext context, value, Widget? child) {
                          return Text('${value + 1}/${widget.product.productPhotos.length}', style: widget.theme.textTheme.labelSmall?.copyWith(fontSize: 10.0, color: AppTheme.palette[600]),);
                        },
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    
    );
  }
}