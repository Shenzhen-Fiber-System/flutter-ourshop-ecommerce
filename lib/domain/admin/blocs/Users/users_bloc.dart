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
    on<Login>((event,emit) async {
      try {
        emit(state.copyWith(status: UserStatus.loading));
        final Auth auth = Auth(
          username: event.data['username'],
          password: event.data['password'],);
        final response =  await _userServices.login(auth);
        if(response is LoggedUser) {
          emit(state.copyWith(
              loggedUser: response, 
              status: UserStatus.logged,
            )
          );
        }
        emit(state.copyWith(status: UserStatus.initial));
      } catch (e) {
        emit(state.copyWith(status: UserStatus.error));
      }
    });
    on<RegisterNewUser>((event, emit) async{
      try {
        emit(state.copyWith(status: UserStatus.registering));
        final NewUser newUser = NewUser(
          username: event.data['username'],
          email: event.data['email'],
          password: event.data['password'],
          name: event.data['name'],
          lastName: event.data['lastName'],
          phoneNumberCode: event.data['phoneNumberCode'],
          phoneNumber: event.data['phoneNumber'],
          countryId: event.data['countryId'],
          companyName: event.data['companyName'],
          rolesIds: event.data['rolesIds'],
          language: _settingsBloc.state.currentLanguage.value,
        );
        final dynamic  user = await _userServices.register(newUser);
        if(user is User) {
          emit(state.copyWith(status: UserStatus.registered));
        }
        emit(state.copyWith(status: UserStatus.initial));
      } catch (e) {
        emit(state.copyWith(status: UserStatus.error));
      }
    });
    on<AddPaymentMethodsEvent>((event,emit) => emit(state.copyWith(cards: event.cards)));
    on<AddPaymentMethodEvent>((event,emit) => emit(state.copyWith(cards: List.from(state.cards)..add(event.card))));
    on<RemovePaymentMethodEvent>((event,emit) => emit(state.copyWith(cards: List.from(state.cards)..remove(event.card))));
    on<AddSelectedCardEvent>((event,emit) => emit(state.copyWith(selectedCard: event.card)));
    on<AddSelectedShippingAddressEvent>((event,emit) => emit(state.copyWith(selectedShippingAddress: event.shippingAddress)));
  }

  void addSelectedCard(PaymentMethod card) => add(AddSelectedCardEvent(card));

  void addSelectedShippingAddress(ShippingAddress shippingAddress) => add(AddSelectedShippingAddressEvent(shippingAddress));
}
