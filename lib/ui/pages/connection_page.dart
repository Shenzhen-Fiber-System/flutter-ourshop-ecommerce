

import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class ConnectivityListener extends StatelessWidget {
  const ConnectivityListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: BlocConsumer<GeneralBloc, GeneralState>(
        listener: (context, state) {
          if (!state.isInterentConnectionActive) {
            const  message = 'No internet connection';
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (BuildContext context, GeneralState state) {
          if (state.isInterentConnectionActive) {
            return child;

          }
          return Center(
            child: Text('No internet connection', style:theme.textTheme.headlineLarge ),
          );
        },
      ),
    );
  }
}