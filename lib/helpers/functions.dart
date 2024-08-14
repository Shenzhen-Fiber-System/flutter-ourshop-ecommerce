


import 'package:ourshop_ecommerce/enums/enums.dart';

class Helpers{

  static String maskCardNumber(String cardNumber) {
    return cardNumber.replaceAll(RegExp(r'\d(?=\d{4})'), '*');
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  static CardType getCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return CardType.VISA;
    } else if (cardNumber.startsWith(RegExp(r'5[1-5]')) || 
              cardNumber.startsWith(RegExp(r'222[1-9]')) ||
              cardNumber.startsWith(RegExp(r'22[3-9]')) || 
              cardNumber.startsWith(RegExp(r'2[3-6]')) ||
              cardNumber.startsWith(RegExp(r'27[0-1]')) || 
              cardNumber.startsWith(RegExp(r'2720'))) {
      return CardType.MASTERCARD;
    } else {
      return CardType.UNKNOWN;
    }
  }
}