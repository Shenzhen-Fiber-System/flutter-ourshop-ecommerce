part of 'roles_bloc.dart';

sealed class RolesEvent extends Equatable {
  const RolesEvent();

  @override
  List<Object> get props => [];
}

class AddRolesEvent extends RolesEvent {
  final List<Role> roles;
  const AddRolesEvent(this.roles);

  @override
  List<Object> get props => [roles];
}

class SelectedRolesEvent extends RolesEvent {
  final List<String> selectedRoles;
  const SelectedRolesEvent(this.selectedRoles);

  @override
  List<Object> get props => [selectedRoles];
}
