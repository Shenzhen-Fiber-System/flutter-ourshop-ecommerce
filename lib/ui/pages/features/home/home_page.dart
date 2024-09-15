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
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final List<Widget> pages = [
    const ProductsPage(),
    const SearchPage(),
    const Cart(),
    const MyAccount()
  ];


  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations  = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        useLegacyColorScheme: false,
        showUnselectedLabels: true,
        currentIndex: context.watch<GeneralBloc>().state.selectedBottomNavTab,
        onTap: 
        context.watch<ProductsBloc>().state.productsStates == ProductsStates.loading 
          ? null 
          : (value) {
            _pageController.jumpToPage(value);
            context.read<GeneralBloc>().add(ChangeBottomNavTab(value));
          },
        items:   [
          BottomNavigationBarItem( label: translations.home, icon:const Icon(Icons.home)),
          BottomNavigationBarItem( label: translations.search, icon:const Icon(Icons.search)),
          BottomNavigationBarItem( label: '${translations.cart} ${context.watch<ProductsBloc>().state.cartProducts.length.toString()}', 
            icon: const Icon(Icons.shopping_cart)
          ),
          BottomNavigationBarItem( label: translations.my_account, icon:const Icon(Icons.person)),
        ]
      ),
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
      this.onTap, 
      this.height,
      this.width
    });

  final Category category;
  final Size size;
  final AppLocalizations translations;
  final ThemeData theme;
  final void Function (Category?)? onTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if(category.subCategories!.isEmpty) {
      return Center(child: Text(translations.no_sub_categories_found, style: theme.textTheme.titleMedium?.copyWith(color: Colors.black)));
    }
    return SizedBox(
      width: width ?? size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.subCategories?.length,
        itemBuilder: (context, index) {
          final Category c = category.subCategories![index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: SubCategoryChip(
              onTap: onTap, 
              c: c, 
              theme: theme
            ),
          );
          // return SubcategoryCard(
          //   height: size.height * 0.01, 
          //   width: size.width * 0.35,
          //   theme: theme,
          //   translations: translations,
            // urlImage: category.subCategories![index].iconSvg,
          //   children: [
          //     Text(category.subCategories![index].name, style: theme.textTheme.labelSmall,),
          //   ],
          //   onTap: () => onTap != null ? onTap!(category.subCategories![index]) : null,
          // );
        },
      ),
    );
  }
}



