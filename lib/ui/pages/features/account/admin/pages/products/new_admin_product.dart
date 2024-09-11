

import '../../../../../pages.dart';

class NewAdminProduct extends StatelessWidget {
  NewAdminProduct({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations translations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:  Text(translations.new_product),
      ),
      body: ProductForm(formKey: _formKey),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          
        },
      ),
    );
  }
}