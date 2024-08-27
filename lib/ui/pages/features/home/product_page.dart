import '../../pages.dart';


class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key, 
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<ProductsBloc, ProductsState>(
      buildWhen: (previous, current) => previous.categories != current.categories,
      builder: (context, state) {
        if (state.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive(),);
        }
        return DefaultTabController(
          length: state.categories.length,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.20,
                width: size.width,
                child: AppBar(
                  automaticallyImplyLeading: false,
                  title: FormBuilderTextField(
                    name: 'search',
                    autofocus: false,
                    controller: _searchController,
                    style: theme.textTheme.labelLarge?.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: translations.search,
                      hintStyle: theme.textTheme.labelLarge?.copyWith(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (index) => context.read<ProductsBloc>().addSelectedCategory(state.categories[index].id),
                    tabs: state.categories.map((category,) => Tab(
                      text: Helpers.truncateText(category.name, 25), 
                    )).toList(),
                  ),
                  actions: [
                    IconButton(
                      onPressed: state.products.isNotEmpty ?  (){
                        if (state.gridCount == 2) {
                          context.read<ProductsBloc>().changeGridCount(1);
                        } else {
                          context.read<ProductsBloc>().changeGridCount(2);
                        }
                      } : null,
                      icon: const Icon(Icons.grid_view_rounded),
                    )
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: state.categories.map((category) => CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          automaticallyImplyLeading: false,
                          expandedHeight: size.height * 0.14,
                          flexibleSpace: FlexibleSpaceBar(
                            stretchModes: const [StretchMode.zoomBackground],
                            background: SubCategoryList(
                              category: category, 
                              size: size, 
                              translations: translations, 
                              theme: theme,
                              onTap: (selectedSubCategory) => (selectedSubCategory != null) ? Navigator.pushNamed(context, '/sub-category', arguments: selectedSubCategory) : null,          
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
                        if (category.products.isEmpty) return Center(child: Text('No Products Found', style: theme.textTheme.titleMedium,));
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
                  )
                  ).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}