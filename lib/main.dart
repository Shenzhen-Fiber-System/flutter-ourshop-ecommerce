import 'ui/pages/pages.dart';


void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  await dotenv.load(fileName: isProduction ? ".env.prod" : ".env.prod");
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
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
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
        builder: (context, child) {
          return ConnectivityListener(
            child: child!,
          );
        },
      ),
    );
  }
}