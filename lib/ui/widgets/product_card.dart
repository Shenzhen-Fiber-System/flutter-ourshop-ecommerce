import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, 
    required this.height, 
    required this.width, 
    required this.product, 
    required this.theme, 
    required this.translations
  });


  final double height;
  final double width;
  final Product product;
  final ThemeData theme;
  final AppLocalizations translations;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.push('/selected-product', extra: product),
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
                child: Hero(
                  tag: product.id,
                  child: ProductImage(product: product, translations: translations, theme: theme),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Column(
                children: [
                  Text(
                    Helpers.truncateText(product.name, 18),
                    style: theme.textTheme.labelMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('${product.productReviewInfo?.ratingAvg.toStringAsFixed(1)}', style: theme.textTheme.labelMedium?.copyWith(color: Colors.black),),
                      ),
                      RatingBar(
                        initialRating: product.productReviewInfo?.ratingAvg ?? 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: size.width * 0.04,
                        glowColor: Colors.amber,
                        unratedColor: Colors.amber,
                        ratingWidget: RatingWidget(                          
                          full: const Icon(Icons.star, color: Colors.amber,),
                          half: const Icon(Icons.star_half, color: Colors.amber,),
                          empty: const Icon(Icons.star_border, color: Colors.amber,),
                        ),
                        tapOnlyMode: true,
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                  if (product.productReviewInfo?.summary != null && product.productReviewInfo!.summary.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(translations.product_ratings(product.productReviewInfo!.summary.length), style: theme.textTheme.bodySmall,),
                    ],
                  )
                  else const SizedBox.shrink(),
                  const SizedBox(height: 2.0),
                  _SendAnimatedWidget(translations: translations, theme: theme),
                  Row(
                    children: [
                      Text(
                        product.unitPrice != null ? '\$${product.unitPrice?.toStringAsFixed(2)}' : ('\$${product.fboPriceStart?.toStringAsFixed(2)}-\$${product.fboPriceEnd?.toStringAsFixed(2)}'),
                        style: theme.textTheme.labelMedium?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      IconButton.filled(
                        // iconSize: 20.0,
                        style: theme.textButtonTheme.style?.copyWith(
                          backgroundColor: const WidgetStatePropertyAll(Color(0xff003049)),
                          fixedSize: const WidgetStatePropertyAll( Size(10.0, 10.0)),
                        ),
                        onPressed: () => context.read<ProductsBloc>().addCartProduct(product),
                        icon: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text('(min 1)', style: theme.textTheme.labelSmall,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendAnimatedWidget extends StatefulWidget {
  const _SendAnimatedWidget({
    super.key,
    required this.translations,
    required this.theme,
  });

  final AppLocalizations translations;
  final ThemeData theme;

  @override
  State<_SendAnimatedWidget> createState() => _SendAnimatedWidgetState();
}

class _SendAnimatedWidgetState extends State<_SendAnimatedWidget> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller
      ]),
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: _animation.value,
          child: child
        );

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.translations.send, style: widget.theme.textTheme.labelMedium?.copyWith(color: Colors.pink),),
          const Padding(
            padding: EdgeInsets.only(left:5.0),
            child: Icon(Icons.delivery_dining, color: Colors.pink, size: 20.0,),
          )
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.product,
    required this.translations,
    required this.theme,
  });

  final Product product;
  final AppLocalizations translations;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image(
        image: NetworkImage(product.photos.isNotEmpty ? '${dotenv.env['PRODUCT_URL']}${product.photos.first.url}' : 'https://placehold.co/600x400'),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          }
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
            child: child,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported, size: 50.0, color: Colors.grey.shade500,),
              Text(translations.no_image, style: theme.textTheme.labelMedium?.copyWith(color: Colors.grey.shade500)),
            ],
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator.adaptive());
        },
        fit: BoxFit.cover,
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  const CartCard({
    super.key, 
    required this.product, 
    this.height, 
    this.width, 
    this.showCheckBox = false, 
    this.showIncreaseDecrease = false, 
    this.showFavoriteButton = false
  });

  final Product product;
  final double? height;
  final double? width;
  final bool? showCheckBox;
  final bool? showIncreaseDecrease;
  final bool? showFavoriteButton;
  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.15,
      width: width ?? MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade500,
            width: 1.0,
          ),
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [ 
          if (showCheckBox!) 
            Align(
              alignment: Alignment.centerLeft,
              child: Checkbox(
                value: product.selected, 
                onChanged: (value) => context.read<ProductsBloc>().selectOrDeselectCartProduct(product)
                
              ),
            )
          else const SizedBox.shrink(),
          SizedBox(
            width: size.width * 0.3,
            height: size.height,
            child: ProductImage(product: product, translations: translations, theme: theme),
          ),
          Expanded(
            child:  BlocBuilder<ProductsBloc, ProductsState>(
              builder: (_, state) {
                // if (!showFavoriteButton!){
                //   return ListTile(
                //     shape: const RoundedRectangleBorder(
                //       side: BorderSide.none
                //     ),
                //     title: Text(Helpers.truncateText(product.name, 18), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),),
                //     // title: const Text('data'),
                //     subtitle: Text('\$${product.unitPrice?.toStringAsFixed(2) ?? 0.00}', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black, fontWeight:  FontWeight.w600),),
                //     // trailing: IncreaseDecrease(theme: theme, product: product),
                //   );
                // }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(Helpers.truncateText(product.name, 18), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),),
                      ],
                    ),
                    Row(
                      children: [
                        Text((product.unitPrice! * product.quantity).toStringAsFixed(2), style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black, fontWeight:  FontWeight.w600),),
                      ],
                    ), 
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.read<ProductsBloc>().addFavoriteProduct(product),
                          child: Icon(state.favoriteProducts.contains(product) ? Icons.favorite : Icons.favorite_border_outlined, color: state.favoriteProducts.contains(product) ? Colors.red : Colors.grey ,)
                        ),
                        const Spacer(),
                        IncreaseDecrease(theme: theme, product: product),
                        
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IncreaseDecrease extends StatelessWidget {
  const IncreaseDecrease({super.key, required this.theme, required this.product});

  final ThemeData theme;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => context.read<ProductsBloc>().removeCartProduct(product),
          icon: Icon(Icons.remove_circle_outline, color: AppTheme.palette[500],),
        ),
        Text(product.quantity.toString(), style: theme.textTheme.labelMedium?.copyWith(color: AppTheme.palette[700]),),
        IconButton(
          onPressed: () => context.read<ProductsBloc>().addCartProduct(product),
          icon: Icon(Icons.add_circle_outline, color: AppTheme.palette[500]),
        ),
      ],
    );
  }
}