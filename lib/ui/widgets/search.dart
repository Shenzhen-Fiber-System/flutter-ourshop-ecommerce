import 'package:ourshop_ecommerce/models/models.dart';
import 'package:ourshop_ecommerce/ui/pages/pages.dart';

class Search extends SearchDelegate{

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return  Center(child: Text('Results', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(child: Text('Suggestions', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),));
  }
}