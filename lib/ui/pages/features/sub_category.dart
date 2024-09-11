import 'dart:developer';

import '../pages.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {

  CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  void initState() {
    fetchData().then((_) => log('fetchData completed'));
    super.initState();
  }


  Future<void> fetchData() async {
    await context.read<ProductsBloc>().fetchSubCategoriesWithProducts(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;

    return BlocBuilder<ProductsBloc,ProductsState>(
      key: UniqueKey(),
      builder: (BuildContext context, state) {

        if (state.productsStates == ProductsStates.loading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.subCategoryProducts.isEmpty && state.subCategories.isEmpty) {
          return Stack(
            children: [
              Positioned(
                top: size.height * 0.05,
                left: size.width * 0.01,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black,), 
                  onPressed: () => context.go('/sub-category/${state.selectedSubCategory.parentCategoryId}'),
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomScrollView(
                key: UniqueKey(),
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white,), 
                      onPressed: () {
                        if (state.selectedParentCategory == state.selectedSubCategory.parentCategoryId) {
                          context.go('/home');
                          return;
                        }
                        context.go('/sub-category/${state.selectedSubCategory.parentCategoryId}');
                      },
                    ),
                    backgroundColor: AppTheme.palette[900],
                    expandedHeight: state.categoryHeaderImages.isNotEmpty ? size.height * 0.20 : size.height * 0.05,
                    title: state.categoryHeaderImages.isNotEmpty ? const SizedBox.shrink() : Text(state.selectedSubCategory.name, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),),
                    flexibleSpace: state.categoryHeaderImages.isNotEmpty ? CarouselSlider(
                      items: state.categoryHeaderImages.map((e) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
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
                    ) : const SizedBox.shrink()
                  ),
                  if (state.subCategories.isNotEmpty) 
                   SliverToBoxAdapter(
                    child: SizedBox(
                      // height: size.height * 0.20,
                      height: size.height * 0.10,
                      width: size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.subCategories.length,
                        itemBuilder: (context, index) {
                          final Category subCategory = state.subCategories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0),
                            child: SubCategoryChip(
                              onTap: (subCateogry) => context.go('/sub-category/${subCategory.id}'),
                              c: subCategory, 
                              theme: theme
                            ),
                          );
                          // return SubcategoryCard(
                          //   height: size.height * 0.15, 
                          //   width: size.width * 0.35,
                          //   theme: theme,
                          //   translations: translations,
                          //   urlImage: subCategory.iconSvg ?? '',
                          //   children: [
                          //     Text(subCategory.name, style: theme.textTheme.labelSmall,),
                          //   ],
                          //   onTap: () => context.go('/sub-category/${subCategory.id}'),
                          // );
                        },
                      ),
                    ),
                  )
                  else const SliverToBoxAdapter(child: SizedBox.shrink()),
                  SliverAnimatedGrid(
                    initialItemCount: state.subCategoryProducts.length,
                    itemBuilder: (context, index, animation) {
                      final Product product = state.subCategoryProducts[index];
                      return FadeTransition(
                        opacity: animation,
                        child: ProductCard(
                          height: size.height * 0.35, 
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
                      childAspectRatio: 0.7
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: CustomFloatingActionButton(
                  onClick: () => context.push('/cart'),
                  type: FloatingActionButtonType.CART,
                  child: const Icon(
                    Icons.shopping_cart, color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}