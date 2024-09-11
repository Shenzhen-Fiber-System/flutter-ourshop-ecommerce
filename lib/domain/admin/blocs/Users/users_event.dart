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


class AddPaymentMethodsEvent extends UsersEvent {
  final List<PaymentMethod> cards;
  const AddPaymentMethodsEvent(this.cards);
  @override
  List<Object> get props => [cards];
}

class AddPaymentMethodEvent extends UsersEvent {
  final PaymentMethod card;
  const AddPaymentMethodEvent(this.card);
  @override
  List<Object> get props => [card];
}

class RemovePaymentMethodEvent extends UsersEvent {
  final PaymentMethod card;
  const RemovePaymentMethodEvent(this.card);
  @override
  List<Object> get props => [card];
}

class AddSelectedCardEvent extends UsersEvent {
  final PaymentMethod card;
  const AddSelectedCardEvent(this.card);
  @override
  List<Object> get props => [card];
}

class AddSelectedShippingAddressEvent extends UsersEvent {
  final ShippingAddress shippingAddress;
  const AddSelectedShippingAddressEvent(this.shippingAddress);
  @override
  List<Object> get props => [shippingAddress];
}

class AddIsLoadingUevent extends UsersEvent {
  final bool isLoading;
  const AddIsLoadingUevent(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}
