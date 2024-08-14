import 'ui/pages/pages.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await dotenv.load(fileName: isProduction ? ".env.prod" : ".env.dev");
  Bloc.observer = Observable();
  await initializeServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<SettingsBloc>()),
        BlocProvider(create: (_) => locator<RolesBloc>()),
        BlocProvider(create: (_) => locator<CompanyBloc>()),
        BlocProvider(create: (_) => locator<CountryBloc>()),
        BlocProvider(create: (_) => locator<UsersBloc>()),
        BlocProvider(create: (_) => locator<GeneralBloc>()),
        BlocProvider(create: (_) => locator<ProductsBloc>()),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('zh')
        ],
        themeMode: ThemeMode.system,
        theme: context.watch<SettingsBloc>().state.currentTheme == ThemeMode.light ? AppTheme.light : AppTheme.dark,
        locale: Locale(context.watch<SettingsBloc>().state.currentLanguege.value),
        debugShowCheckedModeBanner: true,
        initialRoute: AppRoutes.initialPage,
        routes: AppRoutes.routes,
        onGenerateInitialRoutes: (_){
          final String? lastVisitedPage = locator<Preferences>().preferences['last_visited_page'];
          if ((lastVisitedPage != null &&lastVisitedPage.isEmpty) || lastVisitedPage == null) {
            return [
              MaterialPageRoute(
                builder: (_) => const SplashPage()
              ),
            ];
          }
          switch (lastVisitedPage) {
            case 'splash_page':          
            return [
              MaterialPageRoute(
                builder: (_) => const SplashPage()
              ),
            ];
            case 'choose_language_page':
            return [
              MaterialPageRoute(
                builder: (_) => const ChooseLanguagePage()
              ),
            ];
            case 'sign_in_page':
            return [
              MaterialPageRoute(
                builder: (_) => const SignInPage()
              ),
            ];
            default:
            return [
              MaterialPageRoute(
                builder: (_) => const SplashPage()
              ),
            ];
          }
        },
        builder: (context, child) {
          return ConnectivityListener(
            child: child!,
          );
        },
      ),
    );
  }
}