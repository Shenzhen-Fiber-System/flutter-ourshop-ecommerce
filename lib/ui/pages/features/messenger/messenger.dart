import '../../pages.dart';

class Messenger extends StatelessWidget {
  const Messenger({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.white,
        child:  Center(child: Text('Search products...', style: theme.textTheme.titleMedium,)),
      ),
    );
  }
}