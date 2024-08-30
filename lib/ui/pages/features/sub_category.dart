import 'dart:developer';

import 'package:ourshop_ecommerce/models/models.dart';
import '../pages.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({super.key, required this.category});
  final Category category;

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {

  CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  void deactivate() {
    super.deactivate();
    context.read<ProductsBloc>().add(const AddCategoryHeaderImagesEvent(categoryHeaderImages: []));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;

    log('category: ${widget.category.id}');

    return FutureBuilder<List<Product>>(
      future: context.read<ProductsBloc>().getProductsByCategory(widget.category.id),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!!!', style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),));
        }
        if (snapshot.data == null) {
          return Center(child: Text('No data', style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),));
        }

        if (snapshot.data!.isEmpty && widget.category.subCategories!.isEmpty) {
          return Stack(
            children: [
              Positioned(
                top: size.height * 0.05,
                left: size.width * 0.01,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black,), 
                  onPressed: () => Navigator.pop(context)
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(translations.no_Categories_products_found, style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),)
              )
            ]
          );
        }

        return SafeArea(
          top: true,
          child: BlocConsumer<ProductsBloc, ProductsState>(
            listenWhen: (previous, current) => current.cartProducts.length > previous.cartProducts.length,
            listener: (context, state) {
              if (state.cartProducts.isNotEmpty) {
                SuccessToast(title: translations.product_added_to_cart).showToast(context);
              }
            },
            buildWhen: (previous, current) => previous.products != current.products || previous.categoryHeaderImages != current.categoryHeaderImages,
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: state.categoryHeaderImages.isNotEmpty ? size.height * 0.20 : size.height * 0.10,
                    title: state.categoryHeaderImages.isNotEmpty ? const SizedBox.shrink() : Text(widget.category.name, style: theme.textTheme.titleLarge,),
                    flexibleSpace: state.categoryHeaderImages.isNotEmpty ? CarouselSlider(
                      items: state.categoryHeaderImages.map((e) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              // margin: const EdgeInsets.only(top: 10.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(e),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                        initialPage: 2,
                      ),
                    ) :const SizedBox.shrink()
                  ),
                  if (widget.category.subCategories!.isNotEmpty) SliverToBoxAdapter(
                    child: SizedBox(
                      height: size.height * 0.20,
                      width: size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.category.subCategories?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Category c = widget.category.subCategories![index];
                          return CustomCard(
                            height: size.height * 0.15, 
                            width: size.width * 0.35,
                            theme: theme,
                            translations: translations,
                            children: [
                              Text(c.name, style: theme.textTheme.labelSmall,),
                            ],
                            onTap: () async {
                              // log('current selected category: ${c.id}');
                              // await Navigator.pushNamed(context, '/sub-category', arguments: c);
                              await context.push('/sub-category', extra: c);
                            },
                          );
                        },
                      ),
                    ),
                  ) else const SliverToBoxAdapter(child: SizedBox.shrink()),
                  SliverAnimatedGrid(
                    initialItemCount: snapshot.data!.length,
                    itemBuilder: (context, index, animation) {
                      final Product product = snapshot.data![index];
                      return FadeTransition(
                        opacity: animation,
                        child: ProductCard(
                          height: size.height * 0.25, 
                          width: size.width * 0.35,
                          theme: theme,
                          translations: translations, 
                          product: product,
                        ),
                      );
                    }, 
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}