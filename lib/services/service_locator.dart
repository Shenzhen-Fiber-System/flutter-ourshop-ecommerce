
import 'package:ourshop_ecommerce/ui/pages/pages.dart';

GetIt locator = GetIt.instance;

Future<void> initializeServiceLocator() async {

  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => ImagePicker());
  // get preferences
  await locator<Preferences>().getpreferences();

  locator.registerSingleton(GeneralBloc());
  locator.registerSingleton(SettingsBloc());

  //admin
  await admin(DioInstance('admin').instance);

  //product
  await product(DioInstance('product').instance);

  //order
  await order(DioInstance('order').instance);

}

Future<void> admin(Dio instance) async {

  final AuthService authService = locator.registerSingleton(AuthService(dio: instance));

  final RoleServices roleServices = locator.registerSingleton(RoleServices(dio: instance));
  final RolesBloc rolesBloc = locator.registerSingleton(RolesBloc(roleServices));

  final CompanyService companyService = locator.registerSingleton(CompanyService(dio: instance));

  final CompanyBloc companyBloc = locator.registerSingleton(CompanyBloc(companyService));

  final CountryService countryService = locator.registerSingleton(CountryService(dio: instance));
  final CountryBloc countryBloc = locator.registerSingleton(CountryBloc(countryService));
  
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
  final CategoryService categoryService = locator.registerSingleton(CategoryService(dio: instance));
  locator.registerSingleton(ProductsBloc(productService, categoryService ,locator<GeneralBloc>()));
}

Future<void> order(Dio instance) async {
  final OrderService orderService = locator.registerSingleton(OrderService(dio: instance));
  locator.registerSingleton(OrdersBloc(orderService));
}
