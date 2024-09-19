import '../../pages.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key, 
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with TickerProviderStateMixin {

  // late ScrollController _scrollController;
  final Map<String, ScrollController> _scrollControllers = {};

  @override
  void initState() {     
    context.read<ProductsBloc>().add(const AddCategoriesEvent());
    // _scrollController = ScrollController()..addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    // _scrollController.removeListener(listener);
    _scrollControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  // void listener() {
  //   final double threshold = _scrollController.position.maxScrollExtent * 0.05;
  //   if (_scrollController.position.pixels >= threshold && 
  //       context.read<ProductsBloc>().state.hasMore && 
  //       context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
  //       fetchFilteredProducts();
  //   }
  // }

  ScrollController _getOrCreateScrollController(String categoryId) {
    if (!_scrollControllers.containsKey(categoryId)) {
      _scrollControllers[categoryId] = ScrollController()..addListener(() {
        final double threshold = _scrollControllers[categoryId]!.position.maxScrollExtent * 0.05;
        if (_scrollControllers[categoryId]!.position.pixels >= threshold && 
            context.read<ProductsBloc>().state.hasMore && 
            context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
          fetchFilteredProducts();
        }
      });
    }
    return _scrollControllers[categoryId]!;
  }

  void fetchFilteredProducts() {
    context.read<ProductsBloc>().add(AddFilteredProductsEvent(
        page: context.read<ProductsBloc>().state.currentPage + 1, 
        mode: FilteredResponseMode.generalCategoryProducts, 
        categoryId: context.read<ProductsBloc>().state.selectedParentCategory,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<ProductsBloc, ProductsState>(
      buildWhen: (previous, current) => previous.categories != current.categories || previous.productsStates != current.productsStates || previous.selectedParentCategory != current.selectedParentCategory || previous.parentCategoryLoaded != current.parentCategoryLoaded,
      builder: (context, state) {

        if (!state.parentCategoryLoaded)  return const Center(child: CircularProgressIndicator.adaptive());

        if (state.productsStates == ProductsStates.error) return Center(child: Text('Something went wrong!', style: theme.textTheme.bodyMedium?.copyWith(color: AppTheme.palette[1000]),));

        return DefaultTabController(
          initialIndex: state.selectedParentCategory.isEmpty ? 0 : state.categories.indexWhere((element) => element.id == state.selectedParentCategory),
          length: state.categories.length,
          child: SafeArea(
            top: true,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(size.width, size.height * 0.12),
                child: IgnorePointer(
                  ignoring: state.productsStates == ProductsStates.loadingMore || state.productsStates == ProductsStates.loading,
                  child: AppBar(
                    backgroundColor: AppTheme.palette[900],
                    leadingWidth: size.width * 0.25,
                    automaticallyImplyLeading: false,
                    leading: FittedBox(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => showSearch(context: context, delegate: Search()),
                            icon: const Icon(Icons.search, color: Colors.white,)
                          ),
                          Text(translations.search, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),)
                        ],
                      ),
                    ),
                    centerTitle: true,
                    title: Image.asset('assets/logos/logo_ourshop_1.png', height: 150, width: 150,),
                    bottom: TabBar(
                      unselectedLabelStyle: theme.tabBarTheme.unselectedLabelStyle?.copyWith(color: Colors.white),
                      labelStyle: theme.tabBarTheme.unselectedLabelStyle?.copyWith(color: Colors.white),
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      onTap: (index) => context.read<ProductsBloc>().add(AddSelectedParentCategoryEvent(selectedParentCategory: state.categories[index].id,)),
                      tabs: state.categories.map((category,) => Tab(
                          text: Helpers.truncateText(category.name, 25), 
                        )
                      ).toList(),
                    ),
                  ),
                ),
              ),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: TabBarView(
                  children: state.categories.map((category) {
                    switch (category.id) {
                      case "all":  
                        return const AllProducts();
                      default:
                        return SizedBox(
                          height: size.height,
                          width: size.width,
                          child: Column(
                          key: PageStorageKey<String>(category.id),
                          children: [
                              Container(
                                color: Colors.red,
                                height: size.height * 0.08,
                                width: size.width,
                                child: SubCategoryList(
                                  category: category, 
                                  size: size, 
                                  translations: translations, 
                                  theme: theme,
                                  onTap: (selectedSubCategory) {
                                    if (selectedSubCategory != null) {
                                      context.go('/sub-category/${selectedSubCategory.id}',);
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                child: 
                                state.productsStates == ProductsStates.loading 
                                 ? const Center(child: CircularProgressIndicator.adaptive(),) 
                                 : state.filteredProducts.isEmpty ? Center(child: Text('No Products Found', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),))
                                 : GridView.builder(
                                    controller: _getOrCreateScrollController(category.id),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.6
                                    ),
                                    itemCount: state.hasMore ? state.filteredProducts.length  + 1 : state.filteredProducts.length,
                                    itemBuilder: (context, index) {
                                      if (index == state.filteredProducts.length) {
                                        return const Center(child: CircularProgressIndicator.adaptive());
                                      }
                                      final FilteredProduct product = state.filteredProducts[index];
                                      return ProductCard(
                                        height: size.height, 
                                        width: size.width, 
                                        product: product, 
                                        theme: theme, 
                                        translations: translations
                                      );
                                    },
                                  ),
                              )
                            ],
                          ),
                        );
                    }
                  }
                  ).toList(),
                ),
              )
            ),
          ),
        );
      },
    );
  }
}

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Container(
      color: Colors.amber,
      height: size.height,
      width: size.width,
      child: Text('TODO, OFERTAS DEL DIA ETC...', style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),)
    );
  }
}