# ourshop_ecommerce

- Login and register admin module working [x] Aug 2 2024
- You can see and add into the cart products adn you can update your account information [x] sep 4 2024


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

  @override
  void initState() {     
    context.read<ProductsBloc>().add(const AddCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<ProductsBloc, ProductsState>(
      // buildWhen: (previous, current) => previous.categories != current.categories || previous.productsStates != current.productsStates || previous.selectedParentCategory != current.selectedParentCategory || previous.parentCategoryLoaded != current.parentCategoryLoaded,
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
                  onTap: (index) {
                    // context.read<ProductsBloc>().add(const ResetStatesEvent());
                    context.read<ProductsBloc>().add(AddSelectedParentCategoryEvent(selectedParentCategory: state.categories[index].id,));
                    // context.read<ProductsBloc>().add(AddFilteredProductsEvent(
                    //   categoryId: state.categories[index].id,
                    //   page: context.read<ProductsBloc>().state.currentPage + 1,
                    //   mode: FilteredResponseMode.generalCategoryProducts
                    // ));
                  },
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
                  key: UniqueKey(),
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
                        return ParentCateogries(category: category);
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

class ParentCateogries extends StatefulWidget {
  const ParentCateogries({
    super.key, 
    required this.category,
  });


  final Category category;

  @override
  State<ParentCateogries> createState() => _ParentCateogriesState();
}

class _ParentCateogriesState extends State<ParentCateogries> {

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;

    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return ListView(
        key: PageStorageKey(widget.category.id),
        children: [
          Container(
            color: Colors.red,
            height: size.height * 0.08,
            width: size.width,
            child: SubCategoryList(
              category: widget.category, 
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
          // AppBar(
          //     automaticallyImplyLeading: false,
          //     flexibleSpace: FlexibleSpaceBar(
          //       stretchModes: const [StretchMode.zoomBackground],
          //       background: SubCategoryList(
          //         category: widget.category, 
          //         size: size, 
          //         translations: translations, 
          //         theme: theme,
          //         onTap: (selectedSubCategory) {
          //           if (selectedSubCategory != null) {
          //             context.go('/sub-category/${selectedSubCategory.id}',);
          //           }
          //         },
          //       ),
          //     ),
          // ),
          if (state.productsStates == ProductsStates.loading)
            // const SliverFillRemaining(
            //   hasScrollBody: false,
            //   child: Center(
            //     child: CircularProgressIndicator.adaptive(),
            //   ),
            // )
            const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          else if (widget.category.products.isEmpty)
            // SliverFillRemaining(
            //   hasScrollBody: false,
            //   child: Center(
            //     child: Text(
            //       'No Products Found for this category',
            //       style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),
            //     ),
            //   ),
            // )
            Center(
              child: Text(
                'No Products Found for this category',
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),
              ),
            )
          else
            InfinitScrollProductlist(category: widget.category,)
        ],
                              );
      },
    );
  }
}

class InfinitScrollProductlist extends StatefulWidget {
  const InfinitScrollProductlist({
    super.key,
    required this.category
  });

  final Category category;

  @override
  State<InfinitScrollProductlist> createState() => _InfinitScrollProductlistState();
}

class _InfinitScrollProductlistState extends State<InfinitScrollProductlist> {

  late ScrollController _scrollController;

  @override
  void initState() {
    log('here');
    _scrollController = ScrollController()..addListener(listener);
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    _scrollController.dispose();
    super.dispose();
  }


  @override
  void deactivate() {
    context.read<ProductsBloc>().add(const ResetStatesEvent());
    super.deactivate();
  }

  void fetchData(){
    context.read<ProductsBloc>().add(AddFilteredProductsEvent(
        categoryId: widget.category.id,
        page: context.read<ProductsBloc>().state.currentPage + 1,
        mode: FilteredResponseMode.generalCategoryProducts
      )
    );
  }

  void listener() {
    final double threshold = _scrollController.position.maxScrollExtent * 0.2;
    if (_scrollController.position.pixels >= threshold && 
        context.read<ProductsBloc>().state.hasMore && 
        context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
      fetchData();
    }
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6
            ),
            itemCount:state.hasMore ? widget.category.products.length + 1 : widget.category.products.length,
            itemBuilder: (context, index) {
              if (widget.category.products.isEmpty) return Text('No Products Found', style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500),);
              if (index == widget.category.products.length) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
              final FilteredProduct product = widget.category.products[index];
              return ProductCard(
                height: size.height, 
                width: size.width, 
                product: product, 
                theme: theme, 
                translations: translations
              );
            },
          ),
        );
      },
    );
  }
}