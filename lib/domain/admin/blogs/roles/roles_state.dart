part of 'roles_bloc.dart';

class RolesState extends Equatable {

  final List<Role> roles;
  final List<String> selectedRoles;
  const RolesState({
    this.roles = const [],
    this.selectedRoles = const [],
  });

  RolesState copyWith({
    List<Role>? roles,
    List<String>? selectedRoles,
  }) {
    return RolesState(
      roles: roles ?? this.roles,
      selectedRoles: selectedRoles ?? this.selectedRoles,
    );
  }

  Role get sellerRole => roles.firstWhere((role) => role.name.toLowerCase() == 'seller');

  @override
  List<Object> get props => [roles, selectedRoles];
}
