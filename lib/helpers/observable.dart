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
      if (currentState.socialMedias.length != nextState.socialMedias.length) {
        log('social medias ${nextState.socialMedias.length}');
      }
    } else if (bloc is UsersBloc) {
      final currentState = change.currentState as UsersState;
      final nextState = change.nextState as UsersState;
      if (currentState.loggedUser != nextState.loggedUser) {
        // log('User changed to ${nextState.loggedUser}');
      }
    } else if (bloc is ProductsBloc){
      final currentState = change.currentState as ProductsState;
      final nextState = change.nextState as ProductsState;
      if (currentState.filteredProductsSuggestions != nextState.filteredProductsSuggestions) {
        log('Products changed to ${nextState.filteredProductsSuggestions.length}');
      }
      if (currentState.categories != nextState.categories) {
        log('categories changed to ${nextState.categories.length}');
      }
      
    } else if (bloc is OrdersBloc){
      final currentState = change.currentState as OrdersState;
      final nextState = change.nextState as OrdersState;
      if (currentState.filteredAdminOrders != nextState.filteredAdminOrders) {
        // log('Orders changed to ${nextState.filteredAdminOrders}');
      }
    }
  }
}