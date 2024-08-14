import '../pages/pages.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key, 
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 3,
            spreadRadius: 3,
            offset: const Offset(0, -1),
          )
        ]
      ),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.maxFinite,
      child: Center(
        child: child
      )
    );
  }
}