import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class BottomOptions {
  final String text;
  final IconData icon;
  final Function() onTap;

  BottomOptions({required this.text, required this.icon, required this.onTap});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PageController _pageController;

  Future<void> fetchData() async {
    await context.read<ProductsBloc>().getCategories();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final List<Widget> pages = [
    const ProductsPage(),
    const Messenger(),
    const Cart(),
    const MyAccount()
  ];


  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations  = AppLocalizations.of(context)!;
    // final Size size = MediaQuery.of(context).size;

    // final List<BottomOptions> options = [
    //   BottomOptions(
    //     onTap: () {
        
    //     },
    //     text: translations.home, 
    //     icon: Icons.home,
    //   ),
    //   BottomOptions(
    //     onTap: () {
        
    //     },
    //     text: translations.messenger, 
    //     icon: Icons.message
    //   ),
    //   BottomOptions(
    //     onTap: () {
        
    //     },
    //     text: translations.cart, 
    //     icon: Icons.shopping_cart
    //   ),
    //   BottomOptions(
    //     onTap: () {
        
    //     },
    //     text: translations.my_account, 
    //     icon: Icons.person
    //   ),
    // ];

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
        onTap: (value) {
          _pageController.jumpToPage(value);
          context.read<GeneralBloc>().add(ChangeBottomNavTab(value));
        },
        items:   [
          BottomNavigationBarItem( label: translations.home, icon:const Icon(Icons.home)),
          BottomNavigationBarItem( label: translations.messenger, icon:const Icon(Icons.search)),
          BottomNavigationBarItem( label: '${translations.cart} ${context.watch<ProductsBloc>().state.cartProducts.length.toString()}', 
            icon: const Icon(Icons.shopping_cart)
          ),
          BottomNavigationBarItem( label: translations.my_account, icon:const Icon(Icons.person)),
        ]
      ),
    );
  }
}



class FloatingBottomNavigationBar extends StatefulWidget {
  const FloatingBottomNavigationBar({
    super.key,
    required this.size,
    required this.options,
  });

  final Size size;
  final List<BottomOptions> options;

  @override
  State<FloatingBottomNavigationBar> createState() => _FloatingBottomNavigationBarState();
}

class _FloatingBottomNavigationBarState extends State<FloatingBottomNavigationBar> with TickerProviderStateMixin {

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;


  late AnimationController _translationController;
  late Animation<double> _translationAnimation;

  late AnimationController _zoomController;
  late Animation<double> _zoomAnimation;

  late AnimationController _notificationController;
  late Animation<double> _notificationAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _translationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _scaleController, curve: const Interval(0.10, 0.75, curve: Curves.easeIn)));
    _translationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_translationController);

    _zoomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _zoomAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(CurvedAnimation(parent: _zoomController, curve: const Interval(0.10, 0.75, curve: Curves.easeIn)));

    _notificationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _notificationAnimation = Tween<double>(begin: -10.0, end: 1.0).animate(CurvedAnimation(parent: _notificationController, curve: Curves.easeIn));

    _scaleController.forward();
    _translationController.forward();
    _notificationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _scaleController.dispose();
    _translationController.dispose();
    _zoomController.dispose();
    _notificationController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Positioned(
      bottom: 20.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        height: widget.size.height * 0.10,
        width: widget.size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: const Offset(0.0, 0.0)
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.options.map((option) {
              final int id = widget.options.indexOf(option);
                return Stack(
                  children: [
                    BottomNavigationBarOption(
                      scaleController: _scaleController, 
                      translationController: _translationController, 
                      scaleAnimation: _scaleAnimation, 
                      translationAnimation: _translationAnimation, 
                      widget: widget, 
                      zoomController: _zoomController, 
                      zoomAnimation: _zoomAnimation,
                      id: id,
                      text: option.text, 
                      icon: option.icon, 
                      iconColor: id == context.watch<GeneralBloc>().state.selectedBottomNavTab ? AppTheme.palette[500] : Colors.grey.shade400,
                      textStyle: id == context.watch<GeneralBloc>().state.selectedBottomNavTab ? theme.textTheme.labelSmall?.copyWith(color: AppTheme.palette[500]) : theme.textTheme.labelSmall?.copyWith(color: Colors.grey.shade400),
                      onTap: option.onTap,
                      selectedOption: (id) {
                        context.read<GeneralBloc>().add(ChangeBottomNavTab(id));
                      },
                    ),
                    // 
                    if (id == 2 && context.watch<ProductsBloc>().state.cartProducts.isNotEmpty)
                      Positioned(
                        right: 0.0,
                        top: 1.0,
                        child: AnimatedBuilder(
                          animation: _notificationController,
                          builder: (BuildContext context, Widget? child) {
                            return Transform.translate(
                              offset: Offset(0.0, _notificationAnimation.value),
                              child: child,
                            );
                          },
                          child: CircleAvatar(
                            radius: 7.0,
                            backgroundColor: AppTheme.palette[600],
                            child: Text(
                              context.watch<ProductsBloc>().state.cartProducts.length.toString(),
                              style: theme.textTheme.labelSmall?.copyWith(color: Colors.white, fontSize: 8.0),
                            ),
                          ),
                        ),
                      )
                    else const SizedBox.shrink()
                  ],
                );
            } 
          ).toList()
        ),
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
  final Function (Category?)? onTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if(category.subCategories!.isEmpty) {
      return Center(child: Text(translations.no_sub_categories_found, style: theme.textTheme.titleMedium,));
    }
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: height ?? size.height * 0.20,
      width: width ?? size.width,
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
            onTap: () => onTap != null ? onTap!(category.subCategories![index]) : null,
          );
        },
      ),
    );
  }
}



