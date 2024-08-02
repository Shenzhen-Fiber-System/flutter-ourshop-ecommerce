

import 'dart:developer';
import '../ui/pages/pages.dart';

class Observable extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is SettingsBloc) {
      final currentState = change.currentState as SettingsState;
      final nextState = change.nextState as SettingsState;
      if (currentState.currentLanguege != nextState.currentLanguege) {
        // log('Language changed to ${nextState.currentLanguege}');
      }
    } else if (bloc is RolesBloc) {
      final currentState = change.currentState as RolesState;
      final nextState = change.nextState as RolesState;
      if (currentState.roles.length != nextState.roles.length) {
        // log('Roles changed to ${nextState.roles}');
      }
    } else if (bloc is CompanyBloc) {
      final currentState = change.currentState as CompanyState;
      final nextState = change.nextState as CompanyState;
      if (currentState.companies.length != nextState.companies.length) {
        // log('Companies changed to ${nextState.companies.length}');
      }
    } else if (bloc is UsersBloc) {
      final currentState = change.currentState as UsersState;
      final nextState = change.nextState as UsersState;
      if (currentState.loggedUser != nextState.loggedUser) {
        log('User changed to ${nextState.loggedUser}');
      }
    }
  }
}