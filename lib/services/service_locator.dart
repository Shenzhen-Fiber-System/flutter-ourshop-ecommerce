import 'package:ourshop_ecommerce/ui/pages/pages.dart';

GetIt locator = GetIt.instance;

Future<void> initializeServiceLocator() async {

  locator.registerLazySingleton(() => Preferences());
  // get preferences
  await locator<Preferences>().getpreferences();

  locator.registerSingleton(GeneralBloc());
  locator.registerSingleton(SettingsBloc());

  //admin
  await admin(DioInstance('admin').instance);

  //product
  await product(DioInstance('product').instance);

}

Future<void> admin(Dio instance) async {
  final RoleServices roleServices = locator.registerSingleton(RoleServices(dio: instance));
  final RolesBloc rolesBloc = locator.registerSingleton(RolesBloc(roleServices));

  final CompanyService companyService = locator.registerSingleton(CompanyService(dio: instance));

  final CompanyBloc companyBloc = locator.registerSingleton(CompanyBloc(companyService));

  final CountryService countryService = locator.registerSingleton(CountryService(dio: instance));
  final CountryBloc countryBloc = locator.registerSingleton(CountryBloc(countryService));
  
  final AuthService authService = locator.registerSingleton(AuthService(dio: instance));
  locator.registerSingleton(UsersBloc(authService, locator<SettingsBloc>(), locator<GeneralBloc>()));
  
  // get roles...
  await rolesBloc.getRoles();
  // get companies...
  await companyBloc.getCompanies();
  // get countries...
  await countryBloc.fetchCountries();
}

Future<void> product(Dio instance) async {
  final ProductService productService = locator.registerSingleton(ProductService(dio: instance));
  locator.registerSingleton(ProductsBloc(productService, locator<GeneralBloc>()));
}
