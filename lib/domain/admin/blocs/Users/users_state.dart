part of 'users_bloc.dart';

enum UserStatus {
  login,
  logged,
  registering,
  registered,
  loading,
  loaded,
  success,
  error,
  initial,
}

class UsersState extends Equatable {

  final LoggedUser loggedUser;
  final List<PaymentMethod> cards;
  final PaymentMethod selectedCard;
  final ShippingAddress selectedShippingAddress;
  final List<ShippingAddress> shippingAddresses;
  final UserStatus status;

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
      this.cards = const [
        PaymentMethod(
          id: "1",
          type: CardType.VISA,
          cardNumber: "4234567812345678",
          expirationDate: "12/23",
          cvv: "123"
        ),
        // PaymentMethod(
        //   id: "2",
        //   type: CardType.MASTERCARD,
        //   cardNumber: "5134 5678 1234 5678",
        //   expirationDate: "12/23",
        //   cvv: "123"
        // ),
        // PaymentMethod(
        //   id: "3",
        //   type: CardType.VISA,
        //   cardNumber: "4234 5678 1234 5678",
        //   expirationDate: "12/23",
        //   cvv: "123"
        // ),
        // PaymentMethod(
        //   id: "4",
        //   type: CardType.MASTERCARD,
        //   cardNumber: "5134 5678 1234 5678",
        //   expirationDate: "12/23",
        //   cvv: "123"
        // ),
        // PaymentMethod(
        //   id: "5",
        //   type: CardType.VISA,
        //   cardNumber: "4234 5678 1234 5678",
        //   expirationDate: "12/23",
        //   cvv: "123"
        // ),
        // PaymentMethod(
        //   id: "6",
        //   type: CardType.MASTERCARD,
        //   cardNumber: "5134 5678 1234 5678",
        //   expirationDate: "12/23",
        //   cvv: "123"
        // ),
      ],
      this.selectedCard = const PaymentMethod(
        id: "",
        cardNumber: "",
        type: CardType.UNKNOWN,
        expirationDate: "",
        cvv: "",
      ),
      this.selectedShippingAddress = const ShippingAddress(
        id: '1',
        country: "United States",
        fullName: "John Doe",
        phoneNumber: "+1 1234567890",
        address: "123 Main St",
        addtionalInstructions: "Apartment 4B",
        postalCode: 12345,
        state: "California",
        municipality: "Los Angeles", 
      ),
      this.shippingAddresses = const [
        ShippingAddress(
          id: '1',
          country: "United States",
          fullName: "John Doe",
          phoneNumber: "+1 1234567890",
          address: "123 Main St",
          addtionalInstructions: "Apartment 4B",
          postalCode: 12345,
          state: "California",
          municipality: "Los Angeles", 
        ),
        ShippingAddress(
          id: '2',
          country: "Canada",
          fullName: "Jane Smith",
          phoneNumber: "+1 9876543210",
          address: "456 Maple Ave",
          postalCode: 67890,
          state: "Ontario",
          municipality: "Toronto",
        ),
        ShippingAddress(
          id: '3',
          country: "Mexico",
          fullName: "Benito Juarez",
          phoneNumber: "+52 9998885555",
          address: "La luna",
          addtionalInstructions: "Apartment 4B",
          postalCode: 12345,
          state: "BCS",
          municipality: "SJDC",
        ),
      ],
      this.status = UserStatus.initial,
    });

  UsersState copyWith({
    LoggedUser? loggedUser,
    List<PaymentMethod>? cards,
    PaymentMethod? selectedCard,
    ShippingAddress? selectedShippingAddress,
    UserStatus? status,
  }) {
    return UsersState(
      loggedUser: loggedUser ?? this.loggedUser,
      cards: cards ?? this.cards,
      selectedCard: selectedCard ?? this.selectedCard,
      selectedShippingAddress: selectedShippingAddress ?? this.selectedShippingAddress,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object> get props => [
    loggedUser,
    cards,
    selectedCard,
    selectedShippingAddress,
    status,
  ];
}
