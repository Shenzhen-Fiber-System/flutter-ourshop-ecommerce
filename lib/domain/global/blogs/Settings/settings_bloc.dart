

import 'package:ourshop_ecommerce/enums/enums.dart';

import '../../../../ui/pages/pages.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<ChangeLanguage>((event, emit) => emit(state.copyWith(currentLanguege: event.language)));
    on<ChangeTheme>((event, emit) => emit(state.copyWith(currentTheme: event.theme)));
    on<ChangeSelectedLanguage>((event, emit) => emit(
      state.copyWith(
        selectedLanguage: event.selectedLanguage, 
        currentLanguege: Language.values[event.selectedLanguage],
        disable: false
      )
    ));

  }
}