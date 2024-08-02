part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class AddLoggedUserEvent extends UsersEvent {
  final LoggedUser loggedUser;
  const AddLoggedUserEvent(this.loggedUser);

  @override
  List<Object> get props => [loggedUser];
}

class AddIsLoadingEvent extends UsersEvent {
  final bool isLoading;
  const AddIsLoadingEvent(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}
