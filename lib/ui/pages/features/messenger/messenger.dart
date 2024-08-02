import '../../pages.dart';

class Messenger extends StatelessWidget {
  const Messenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.amber,
      child:  const Text('Messgenger', style: TextStyle(fontSize: 50, color: Colors.black)),
    );
  }
}