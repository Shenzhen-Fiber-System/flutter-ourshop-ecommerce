import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class ChooseLanguagePage extends StatefulWidget {
  const ChooseLanguagePage({super.key});

  @override
  State<ChooseLanguagePage> createState() => _ChooseLanguagePageState();
}

class _ChooseLanguagePageState extends State<ChooseLanguagePage> {

  @override
  void initState() {
    super.initState();
    locator<Preferences>().saveLastVisitedPage('choose_language_page');
  }

  @override
  Widget build(BuildContext context) {
  
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translation = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  text: translation.choose_language,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text.rich(
                  TextSpan(
                  text: translation.change_language_later, 
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                )),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: AvailableLanguages.availableLanguages.length,
                  itemBuilder: (context, index) {
                    final AvailableLanguages availbaleLanguage = AvailableLanguages.availableLanguages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          return ListTile(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            title: Text(availbaleLanguage.name),
                            selected: state.selectedLanguage == availbaleLanguage.id,
                            selectedColor: theme.primaryColor,
                            selectedTileColor: AppTheme.palette[900]!.withOpacity(0.1),
                            leading: Image.network(availbaleLanguage.flag, width: 30, height: 30,),
                            trailing: state.selectedLanguage == availbaleLanguage.id ?  Icon(Icons.check_circle, color: AppTheme.palette[950],) : null,
                            shape: state.selectedLanguage == availbaleLanguage.id ?  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: AppTheme.palette[1000]!,
                                width: 1
                              )
                            ) :  null,
                            onTap: () {
                              context.read<SettingsBloc>().add(ChangeSelectedLanguage(selectedLanguage:availbaleLanguage.id));
                              locator<Preferences>().saveData('language', availbaleLanguage.id.toString());
                            },
                          );
                        },
                      ),
                    );
                  },
                )
              ),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.disable ? null : () => context.go('/'),
                      child: Text(translation.next, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}