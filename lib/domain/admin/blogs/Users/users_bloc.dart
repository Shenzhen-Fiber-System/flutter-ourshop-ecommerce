
import '../../../../ui/pages/pages.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final AuthService _userServices;
  final SettingsBloc _settingsBloc;
  UsersBloc(AuthService userServices, SettingsBloc settingsBloc)
    : _userServices = userServices,
      _settingsBloc = settingsBloc,
    super(const UsersState()){
    on<AddLoggedUserEvent>((event,emit) => emit(state.copyWith(loggedUser: event.loggedUser)));
    on<AddIsLoadingEvent>((event,emit) => emit(state.copyWith(isLoading: event.isLoading)));
  }


  Future<dynamic> loginUser(Map<String, dynamic> data) async {
    add(const AddIsLoadingEvent(true));
    final Auth auth = Auth(
      username: data['username'],
      password: data['password'],);
    final response =  await _userServices.login(auth);
    if(response is LoggedUser) {
      add(AddLoggedUserEvent(response));
    }
    add(const AddIsLoadingEvent(false));
    return response;
  }


  Future<dynamic> registerUser(Map<String, dynamic> data) async {
    add(const AddIsLoadingEvent(true));
    final NewUser newUser = NewUser(
      username: data['username'],
      email: data['email'],
      password: data['password'],
      name: data['name'],
      lastName: data['lastName'],
      phoneNumberCode: data['phoneNumberCode'],
      phoneNumber: data['phoneNumber'],
      countryId: data['countryId'],
      companyName: data['companyName'],
      rolesIds: data['rolesIds'],
      language: _settingsBloc.state.currentLanguege.value,
    );
    final user = await _userServices.register(newUser);
    if(user is User) {
      add(const AddIsLoadingEvent(false));
      return user;
    }
    add(const AddIsLoadingEvent(false));
  }
}
