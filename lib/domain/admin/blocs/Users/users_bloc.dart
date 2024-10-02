import 'dart:developer';

import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../ui/pages/pages.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final AuthService _userServices;
  final SettingsBloc _settingsBloc;
  final GeneralBloc generalBloc;
  final StripeService _stripeService;
  UsersBloc( 
    AuthService userServices, 
    SettingsBloc settingsBloc, 
    this.generalBloc,
    StripeService stripeService
  )
    : _userServices = userServices,
      _settingsBloc = settingsBloc,
      _stripeService = stripeService,
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
    on<MakeStripePaymentEvent>((event, emit) async{
      try {
        emit(state.copyWith(status: UserStatus.paying));
        final response = await _stripeService.createPaymentMethod(event.stripePayment);
        if (response is StripeClient) {
          await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: response.clientSecret,
              merchantDisplayName: 'OurShop',
            )
          );
          await Stripe.instance.presentPaymentSheet();
          final PaymentIntent paymentIntent = await Stripe.instance.retrievePaymentIntent(response.clientSecret);

          final Map<String,dynamic> data= {
            "customerId": state.loggedUser.userId,
            "discount": 0.0,
            "orderItems": []
          };
          // prepare the order data
          final List<Map<String, Object?>> orderItems = locator<ProductsBloc>().state.cartProducts.map((e) => {
            "productId": e.id,
            "qty": e.quantity,
            "price": e.unitPrice
          }).toList();
          data['orderItems'] = orderItems;
          data['payment'] = paymentIntent.toJson();
          
          locator<OrdersBloc>().add(NewOrderEvent(data: data));

          emit(state.copyWith(status: UserStatus.paid));
        }
      } on StripeException catch (e) {
        log('StripeException: ${e.error.message}');
      } catch (e) {
        log('e: $e');
        emit(state.copyWith(status: UserStatus.initial));
      }
    });
  }
}
