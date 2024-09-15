import '../../pages.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key, 
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  // Future<void> fetchData() async {
  //   await context.read<ProductsBloc>().getCategories();
  // }

  @override
  void initState() {     
    // fetchData();
    context.read<ProductsBloc>().add(const AddCategoriesEvent());
    super.initState();
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
              appBar: AppBar(
                backgroundColor: AppTheme.palette[900],
                leadingWidth: size.width * 0.25,
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
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: TabBarView(
                  children: state.categories.map((category) {

                    switch (category.id) {
                      case "all":  
                        return Container(
                          color: Colors.amber,
                          height: size.height,
                          width: size.width,
                          child: Text('TODO, OFERTAS DEL DIA ETC...', style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),)
                        );
                      default:
                        return CustomScrollView(
                        key: UniqueKey(),
                        slivers: [
                          SliverAppBar(
                              automaticallyImplyLeading: false,
                              expandedHeight: size.height * 0.10,
                              flexibleSpace: FlexibleSpaceBar(
                                stretchModes: const [StretchMode.zoomBackground],
                                background: SubCategoryList(
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
                          ),
                          if (state.productsStates == ProductsStates.loading)
                            const SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            )
                          else if (category.products.isEmpty)
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: Text(
                                  'No Products Found for this category',
                                  style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),
                                ),
                              ),
                            )
                          else
                            SliverGrid.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.6
                              ),
                              itemCount: category.products.length,
                              itemBuilder: (context, index) {
                                if (category.products.isEmpty) return Text('No Products Found', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),);
                                if (index == state.filteredProductsSuggestions.length) {
                                  return const Center(child: CircularProgressIndicator.adaptive());
                                }
                                final FilteredProduct product = category.products[index];
                                return ProductCard(
                                  height: size.height, 
                                  width: size.width, 
                                  product: product, 
                                  theme: theme, 
                                  translations: translations
                                );
                              },
                            )
                        ],
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