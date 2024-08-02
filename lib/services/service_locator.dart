import 'package:ourshop_ecommerce/ui/pages/pages.dart';

GetIt locator = GetIt.instance;

Future<void> initializeServiceLocator() async {

  locator.registerLazySingleton(() => Preferences());

  final Dio instance = locator.registerSingleton(DioInstance('admin').instance);

  locator.registerSingleton(GeneralBloc());
  final SettingsBloc settingsBloc = locator.registerSingleton(SettingsBloc());

  final RoleServices roleServices = locator.registerSingleton(RoleServices(dio: instance));
  final RolesBloc rolesBloc = locator.registerSingleton(RolesBloc(roleServices));

  final CompanyService companyService = locator.registerSingleton(CompanyService(dio: instance));

  final CompanyBloc companyBloc = locator.registerSingleton(CompanyBloc(companyService));

  final CountryService countryService = locator.registerSingleton(CountryService(dio: instance));
  final CountryBloc countryBloc = locator.registerSingleton(CountryBloc(countryService));
  
  final AuthService authService = locator.registerSingleton(AuthService(dio: instance));
  locator.registerSingleton(UsersBloc(authService, settingsBloc));


  locator.registerSingleton(ProductsBloc());
  


  // get roles...
  await rolesBloc.getRoles();
  // get companies...
  await companyBloc.getCompanies();
  // get countries...
  await countryBloc.fetchCountries();
  // get preferences
  await validatePreferences();
}

Future<void> validatePreferences () async {
  await locator<Preferences>().getLastVisitedPage();
}