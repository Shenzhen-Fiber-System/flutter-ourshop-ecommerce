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


  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations  = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _HomeView(
            size: size,
          ),
          const Messenger(),
          const Cart(),
          const MyAccount()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.select((GeneralBloc bloc) => bloc.state.selectedBottomNavTab),
        onTap: (value) {
          _pageController.jumpToPage(value);
          context.read<GeneralBloc>().add(ChangeBottomNavTab(value));
        },
        items:   [
          BottomNavigationBarItem( label: translations.home, icon:const Icon(Icons.home)),
          BottomNavigationBarItem( label: translations.messenger, icon:const Icon(Icons.search)),
          BottomNavigationBarItem( label: translations.cart, icon:const Icon(Icons.security_rounded)),
          BottomNavigationBarItem( label: translations.my_account, icon:const Icon(Icons.person)),
        ]
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: double.maxFinite,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
            title: Text('${dotenv.env['MODE']}'),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.line_style_rounded),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.shopping_cart),
              // ),
            ],
          ),
          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return ProductCard(
          //         height: size.height * 0.2, 
          //         width: size.width * 0.2,

          //       );
          //     },
          //     childCount: 10,
          //   ),
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //   ),
          // ),
        ],
      ),
    );
  }
}





