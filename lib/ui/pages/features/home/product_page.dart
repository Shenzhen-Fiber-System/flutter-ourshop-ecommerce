import 'dart:developer';

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
    log('Product page');

    if(context.watch<ProductsBloc>().state.categories.isEmpty) {
       return const Center(child: CircularProgressIndicator.adaptive());
    }

    return DefaultTabController(
      length: context.select((ProductsBloc bloc) => bloc.state.categories.length),
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            onTap: (index) => context.read<ProductsBloc>().addSelectedCategory(context.read<ProductsBloc>().state.categories[index].id),
            tabs: context.read<ProductsBloc>().state.categories.map((category,) => Tab(
              text: Helpers.truncateText(category.name, 25), 
            )).toList(),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: TabBarView(
              children: context.read<ProductsBloc>().state.categories.map((category) => CustomScrollView(
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
                          onTap: (selectedSubCategory) async {
                            await Navigator.pushNamed(context, '/sub-category', arguments: selectedSubCategory!);
                          },    
                        ),
                      ),
                  ),
                SliverGrid.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: context.read<ProductsBloc>().state.gridCount,
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
        ),
      ),
    );
  }
}