part of 'users_bloc.dart';

class UsersState extends Equatable {

  final LoggedUser loggedUser;
  final bool isLoading;

  const UsersState({
      this.loggedUser = const LoggedUser(
        userCountryName: "",
        sub: "",
        companyId: "",
        roles: "",
        companyCountryName: "",
        lastName: "",
        language: "",
        companyMainCategoryId: "",
        companyCurrentBusinessCategoryId: "",
        userPhoneNumber: "",
        companyCountryId: "",
        userId: "",
        userCountryId: "",
        companyName: "",
        name: "",
        userPhoneNumberCode: "",
        exp: 0,
        iat: 0,
        email: "",
      ),
      this.isLoading = false,
    });

  UsersState copyWith({
    LoggedUser? loggedUser,
    bool? isLoading,
  }) {
    return UsersState(
      loggedUser: loggedUser ?? this.loggedUser,
      isLoading: isLoading ?? this.isLoading,
    );
  }
  
  @override
  List<Object> get props => [loggedUser, isLoading];
}
