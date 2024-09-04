import '../../pages.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key, 
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  Future<void> fetchData() async {
    await context.read<ProductsBloc>().getCategories();
  }

  @override
  void initState() {     
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {

        if (state.prodyctsStates == ProductsStates.loading)  return const Center(child: CircularProgressIndicator.adaptive());

        if (state.prodyctsStates == ProductsStates.error) return Center(child: Text('Something went wrong!', style: theme.textTheme.bodyMedium,));

        return DefaultTabController(
          initialIndex: state.selectedParentCategory.isEmpty ? 0 : state.categories.indexWhere((element) => element.id == state.selectedParentCategory),
          length: state.categories.length,
          child: SafeArea(
            top: true,
            child: Scaffold(
              appBar: TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (index) => context.read<ProductsBloc>().addSelectedCategory(state.categories[index].id),
                tabs: state.categories.map((category,) => Tab(
                  text: Helpers.truncateText(category.name, 25), 
                )).toList(),
              ),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: TabBarView(
                  children: state.categories.map((category) {
                    return CustomScrollView(
                    key: UniqueKey(),
                    slivers: [
                      SliverAppBar(
                          automaticallyImplyLeading: false,
                          expandedHeight: size.height * 0.20,
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
                    SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: state.gridCount,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.7
                      ),
                      itemCount: category.products.length,
                      itemBuilder: (context, index) {
                        if (category.products.isEmpty) return Text('No Products Found', style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),);
                        final Product product = category.products[index];
                        return ProductCard(
                          height: size.height * 0.25, 
                          width: size.width * 0.45,
                          theme: theme,
                          translations: translations, 
                          product: product,
                        );
                      },
                    )
                    ],
                  );
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