
import 'package:ourshop_ecommerce/enums/enums.dart';

import '../../../../ui/pages/pages.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final AuthService _userServices;
  final SettingsBloc _settingsBloc;
  final GeneralBloc generalBloc;
  UsersBloc(AuthService userServices, SettingsBloc settingsBloc, this.generalBloc)
    : _userServices = userServices,
      _settingsBloc = settingsBloc,
    super(const UsersState()){
    on<AddLoggedUserEvent>((event,emit) => emit(state.copyWith(loggedUser: event.loggedUser)));
    on<AddPaymentMethodsEvent>((event,emit) => emit(state.copyWith(cards: event.cards)));
    on<AddPaymentMethodEvent>((event,emit) => emit(state.copyWith(cards: List.from(state.cards)..add(event.card))));
    on<RemovePaymentMethodEvent>((event,emit) => emit(state.copyWith(cards: List.from(state.cards)..remove(event.card))));
    on<AddSelectedCardEvent>((event,emit) => emit(state.copyWith(selectedCard: event.card)));
    on<AddSelectedShippingAddressEvent>((event,emit) => emit(state.copyWith(selectedShippingAddress: event.shippingAddress)));
  }


  Future<dynamic> loginUser(Map<String, dynamic> data) async {
    generalBloc.add(const AddIsLoadingEvent(true));
    final Auth auth = Auth(
      username: data['username'],
      password: data['password'],);
    final response =  await _userServices.login(auth);
    if(response is LoggedUser) {
      add(AddLoggedUserEvent(response));
      return response;
    }
    generalBloc.add(const AddIsLoadingEvent(false));
  }


  Future<dynamic> registerUser(Map<String, dynamic> data) async {
    generalBloc.add(const AddIsLoadingEvent(true));
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
      generalBloc.add(const AddIsLoadingEvent(false));
      return user;
    }
    generalBloc.add(const AddIsLoadingEvent(false));
  }


  void addSelectedCard(PaymentMethod card) => add(AddSelectedCardEvent(card));

  void addSelectedShippingAddress(ShippingAddress shippingAddress) => add(AddSelectedShippingAddressEvent(shippingAddress));
}
