import '../ui/pages/pages.dart';

class AppRoutes{

  static const String initialPage = '/';
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => const SignInPage(),
    '/sign-up': (_) => const SignUpPage(),
    '/home' : (_) => const HomePage(),
    '/selected-product': (_) => const SelectedProductPage(),
    '/sub-category': (_) => const SubCategoryPage(),
    '/checkout': (_) => const CheckoutPage(),
  };

}