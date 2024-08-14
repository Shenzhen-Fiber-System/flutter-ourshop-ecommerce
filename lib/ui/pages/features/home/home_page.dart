import 'dart:developer';

import 'package:ourshop_ecommerce/ui/pages/pages.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().getCategories();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations  = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          _ProductsView(
            size: size,
            translations: translations, 
            theme: theme,
          ),
          const Messenger(),
          const Cart(),
          const MyAccount()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        useLegacyColorScheme: false,
        currentIndex: context.watch<GeneralBloc>().state.selectedBottomNavTab,
        onTap: (value) {
          _pageController.jumpToPage(value);
          context.read<GeneralBloc>().add(ChangeBottomNavTab(value));
        },
        items:   [
          BottomNavigationBarItem( label: translations.home, icon:const Icon(Icons.home)),
          BottomNavigationBarItem( label: translations.messenger, icon:const Icon(Icons.search)),
          BottomNavigationBarItem( label: translations.cart, icon:const Icon(Icons.shopping_cart)),
          BottomNavigationBarItem( label: translations.my_account, icon:const Icon(Icons.person)),
        ]
      ),
    );
  }
}

class _ProductsView extends StatefulWidget {
  const _ProductsView({
    required this.size, required this.translations, required this.theme,
  });

  final Size size;
  final AppLocalizations translations;
  final ThemeData theme;

  @override
  State<_ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<_ProductsView>{

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
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if(state.isLoading) return const Center(child: CircularProgressIndicator.adaptive());
        // if(state.products.isEmpty) return const Center(child: Text('No Products Found'));
        return DefaultTabController(
          length: state.categories.length,
          child: Scaffold(
            appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: FormBuilderTextField(
                    name: 'search',
                    autofocus: false,
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: widget.translations.search,
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
            body: TabBarView(
              children: state.categories.map((category) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0, left: 5.0, bottom: 2.0),
                    child: Text(widget.translations.sub_categories, style: widget.theme.textTheme.titleMedium),
                  ),
                  SubCategoryList(
                      category: category, 
                      size: widget.size, 
                      translations: widget.translations, 
                      theme: widget.theme,
                      onTap: () {
                        log('navigate to sub category');
                      },
                  ),
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (category.products.isEmpty) return const SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 2.0),
                        child: Text('Products', style: widget.theme.textTheme.titleMedium),
                      );
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<ProductsBloc, ProductsState>(
                      builder: (context, state) {
                        if (category.products.isEmpty) return Center(child: Text('No Products Found', style: widget.theme.textTheme.titleMedium,));
                        return GridView.builder(
                          itemCount: category.products.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: state.gridCount,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 0.7
                          ),
                          itemBuilder: (context, index) {
                            if (category.products.isEmpty) return const Center(child: Text('No Products Found'));
                            final Product product = category.products[index];
                            return CustomCard(
                              height: widget.size.height * 0.25, 
                              width: widget.size.width * 0.45,
                              theme: widget.theme,
                              translations: widget.translations,
                              children: [
                                Text(product.name, style: widget.theme.textTheme.labelSmall,),
                              ],
                              onTap: (){
                                Navigator.pushNamed(context, '/selected-product', arguments: product);
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              )
              ).toList(),
            ),
          )
        );
      },
    );
  }
}

class SubCategoryList extends StatelessWidget {
  const SubCategoryList({
    super.key,
      required this.category, 
      required this.size, 
      required this.translations, 
      required this.theme,
      this.onTap
    });

  final Category category;
  final Size size;
  final AppLocalizations translations;
  final ThemeData theme;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    if(category.subCategories!.isEmpty) {
      return Center(child: Text(translations.no_sub_categories_found, style: theme.textTheme.titleMedium,));
    }
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: size.height * 0.20,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.subCategories?.length,
        itemBuilder: (context, index) {
          return CustomCard(
            height: size.height * 0.15, 
            width: size.width * 0.35,
            theme: theme,
            translations: translations,
            children: [
              Text(category.subCategories![index].name, style: theme.textTheme.labelSmall,),
            ],
            onTap: () => onTap != null ? onTap!() : null,
          );
        },
      ),
    );
  }
}

// class SubCategory extends StatelessWidget {
//   const SubCategory({
//     super.key, 
//     required this.category, 
//     required this.size, 
//     required this.translations, 
//     required this.theme
//   });

//   final Category category;
//   final Size size;
//   final AppLocalizations translations;
//   final ThemeData theme;

//   @override
//   Widget build(BuildContext context) {
//     if (category.subCategories == null || category.subCategories!.isEmpty) {
//       return Center(child: Text(translations.no_sub_categories_found, style: theme.textTheme.titleMedium,));
//     }
//   }
// }



