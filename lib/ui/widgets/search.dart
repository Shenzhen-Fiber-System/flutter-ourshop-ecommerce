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
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final TextStyle? style = theme.textTheme.bodyMedium?.copyWith(color: Colors.black);
    //TODO implement search suggestions products
    return Center(child: Text('Suggestions', style: style,));
    // return SizedBox(
    //   height: size.height,
    //   width: size.width,
    //   child: FutureBuilder<List<Product>>(
    //     future: context.read<ProductsBloc>().getAllProducts(),
    //     builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       }

    //       if (!snapshot.hasData){
    //         return Center(child: Text('No data', style: style,));
    //       }

    //       if (snapshot.data!.isEmpty) {
    //         return Center(child: Text('No data', style: style,));
    //       }

    //       if (snapshot.hasError) {
    //         log(snapshot.error.toString());
    //         return Center(child: Text('Error', style: style,));
    //       }

    //       return GridView.builder(
    //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2,
    //           crossAxisSpacing: 10,
    //           mainAxisSpacing: 10,
    //           childAspectRatio: 0.7
    //         ),
    //         itemBuilder: (context, index) {
    //           // return ProductCard(
    //           //   product: ,
    //           //   height: size.height,
    //           //   width: size.width, 
    //           //   theme: theme, 
    //           //   translations: translations,
    //           // );
    //           return Text('suggestions', style: style,);
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}