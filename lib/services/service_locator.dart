import 'dart:developer';
import 'package:ourshop_ecommerce/ui/pages/pages.dart';

GetIt locator = GetIt.instance;

Future<void> initializeServiceLocator() async {


  locator.registerLazySingleton<AppLocalizations>(() => AppLocalizations.of(AppRoutes.globalContext!)!);
  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => ImagePicker());
  // get preferences
  await locator<Preferences>().getpreferences();

  locator.registerSingleton(GeneralBloc());
  final int parsetValue = locator<Preferences>().preferences['language'] != null ? int.parse(locator<Preferences>().preferences['language']) : 1;
  locator.registerSingleton(SettingsBloc()).add(ChangeSelectedLanguage(selectedLanguage: parsetValue));

  //admin
  await admin(DioInstance('admin').instance);

  //product
  await product(DioInstance('product').instance);

  //order
  await order(DioInstance('order').instance);

  //
  await communication(DioInstance('communication').instance);

} 

Future<void> admin(Dio instance) async {

  final AuthService authService = locator.registerSingleton(AuthService(dio: instance));

  final RoleServices roleServices = locator.registerSingleton(RoleServices(dio: instance));
  locator.registerSingleton(RolesBloc(roleServices));

  final CompanyService companyService = locator.registerSingleton(CompanyService(dio: instance));
  final SocialMediaService socialMediaService = locator.registerSingleton(SocialMediaService(dio: instance));

  locator.registerSingleton(CompanyBloc(companyService, socialMediaService));

  final CountryService countryService = locator.registerSingleton(CountryService(dio: instance));
  locator.registerSingleton(CountryBloc(countryService));
  
  locator.registerSingleton(UsersBloc(authService, locator<SettingsBloc>(), locator<GeneralBloc>()));
  log('preferences: ${locator<Preferences>().preferences['last_visited_page']}');
    // get roles...
    // await rolesBloc.getRoles();

    // get companies...

    // await companyBloc.getCompanies();

    // get countries...
    // await countryBloc.fetchCountries();
  

}

Future<void> product(Dio instance) async {
  final ProductService productService = locator.registerSingleton(ProductService(dio: instance));
  final CategoryService categoryService = locator.registerSingleton(CategoryService(dio: instance));
  locator.registerSingleton(ProductsBloc(productService, categoryService));
}

Future<void> order(Dio instance) async {
  final OrderService orderService = locator.registerSingleton(OrderService(dio: instance));
  locator.registerSingleton(OrdersBloc(orderService));
}

Future<void> communication(Dio instance) async {
  
  final communicationService = locator.registerSingleton(CommunicationService(dio: instance));
  locator.registerSingleton(CommunicationBloc(communicationService));
}
