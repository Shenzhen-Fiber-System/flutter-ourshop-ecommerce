import '../../pages.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.pink,
      child:  const Text('Cart page', style: TextStyle(fontSize: 50, color: Colors.black)),
    );
  }
}