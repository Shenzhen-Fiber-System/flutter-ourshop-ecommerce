import '../../../../../pages.dart';

class WebEditor extends StatelessWidget {
  const WebEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        title: const Text('Web Editor'),
      ),
      body: const Center(
        child: Text('Web Editor'),
      ),
    );
  }
}