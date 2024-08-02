part of 'settings_bloc.dart';



class SettingsState extends Equatable {

  final Language currentLanguege;
  final ThemeMode currentTheme;
  final int selectedLanguage;
  final bool disable;

  const SettingsState({
    this.currentLanguege = Language.ENGLISH,
    this.currentTheme = ThemeMode.light,
    this.selectedLanguage = -1,
    this.disable = true,
  });

  SettingsState copyWith({
    Language? currentLanguege,
    ThemeMode? currentTheme,
    int? selectedLanguage,
    bool? disable,
  }) => SettingsState(
    currentLanguege: currentLanguege ?? this.currentLanguege,
    currentTheme: currentTheme ?? this.currentTheme,
    selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    disable: disable ?? this.disable,
  );


  
  @override
  List<Object> get props => [
    currentLanguege, 
    currentTheme, 
    selectedLanguage, 
    disable
  ];
}

