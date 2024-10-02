import 'dart:developer';

import '../pages.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // context.read<ProductsBloc>().add(AddSelectedSubCategoryEvent(selectedSubCategoryId: widget.categoryId));
    // context.read<ProductsBloc>().add(AddSubCategoriesEvent(categoryId: widget.categoryId));
    // fetchData();
    _scrollController = ScrollController()..addListener(listener);

  }


  void listener(){
    final double threshold = _scrollController.position.maxScrollExtent * 0.05;
    if (_scrollController.position.pixels >= threshold && 
        context.read<ProductsBloc>().state.hasMore && 
        context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
        fetchData();
    }
  }

  void fetchData(){
    context.read<ProductsBloc>().add(AddSubCategoryProductsEvent(
      mode: FilteredResponseMode.subCategoryProducts, 
      page: context.read<ProductsBloc>().state.subCategoryProductsCurrentPage + 1
    ));
  }

@override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(listener);
    super.dispose();
  }

  // @override
  // void deactivate() {
  //   context.read<ProductsBloc>().add(const ResetStatesEvent());
  //   super.deactivate();
  // }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;

    return BlocBuilder<ProductsBloc,ProductsState>(
      // listener: (context, state) {
      //   if (state.selectedSubCategory.id.isNotEmpty) {
      //     context.go('/sub-category/${state.selectedSubCategory.id}',);
      //   }
      // },
      // listenWhen: (previous, current) {
      //   if (previous.selectedSubCategory != current.selectedSubCategory ) return true;
      //   if (current.selectedParentCategory == current.selectedSubCategory.parentCategoryId) return true;
      //   return false;
      // },
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
                  onPressed: () => context.read<ProductsBloc>().add(AddSelectedSubCategoryEvent(selectedSubCategoryId: state.selectedSubCategory.parentCategoryId))
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
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    AppBar(
                      leading: IconButton(
                        splashColor: Colors.transparent,
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,), 
                        onPressed: () {
                            if (state.selectedParentCategory == state.selectedSubCategory.parentCategoryId) {
                              context.go('/home');
                              return;
                            }
                          // context.go('/sub-category/${state.selectedSubCategory.parentCategoryId}');
                          context.read<ProductsBloc>().add(AddSelectedSubCategoryEvent(selectedSubCategoryId: state.selectedSubCategory.parentCategoryId));
                        },
                      ),
                      backgroundColor: AppTheme.palette[900],
                      title: state.categoryHeaderImages.isNotEmpty ? const SizedBox.shrink() : Text(state.selectedSubCategory.name, style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),),
                    ),
                    if (state.subCategories.isNotEmpty) 
                     SizedBox(
                      //  height: size.height * 0.20,
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
                               onTap: (selectedSubCategory) {
                                log('here--- $selectedSubCategory');
                                context.read<ProductsBloc>().add(AddSelectedSubCategoryEvent(selectedSubCategoryId: selectedSubCategory.id));
                                //  context.go('/sub-category/${selectedSubCategory.id}');
                               },
                               c: subCategory, 
                               theme: theme
                             ),
                           );
                         },
                       ),
                     )
                    else const SizedBox.shrink(),
                    Expanded(
                      child: 
                          state.subCategoryProducts.isEmpty ? Center(child: Text('No Products Found', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),))
                         : GridView.builder(
                            controller: _scrollController,
                            itemCount: state.hasMore ? state.subCategoryProducts.length + 1  : state.subCategoryProducts.length,
                            itemBuilder: (context, index) {
                              if (index == state.subCategoryProducts.length) {
                                return const Center(child: CircularProgressIndicator.adaptive());
                              }
                              final FilteredProduct product = state.subCategoryProducts[index];
                              return ProductCard(
                                height: size.height * 0.35, 
                                width: size.width * 0.35,
                                theme: theme,
                                translations: translations, 
                                product: product,
                              );
                            }, 
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.6
                            ),
                          )
                    )
                  ],
                ),
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