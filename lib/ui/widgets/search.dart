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
    return  SearchSuggestions(query: query,);
  }
}


class SearchSuggestions extends StatefulWidget {
  const SearchSuggestions({super.key, required this.query});


  final String query;

  @override
  State<SearchSuggestions> createState() => _SearchSuggestionsState();
}

class _SearchSuggestionsState extends State<SearchSuggestions> {


  late ScrollController _scrollController;

  @override
  void initState() {
    fetchFilteredProducts();
    _scrollController = ScrollController()..addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    _scrollController.dispose();
    super.dispose();
  }


  void listener() {
    final double threshold = _scrollController.position.maxScrollExtent * 0.1;
    if (_scrollController.position.pixels >= threshold && 
        context.read<ProductsBloc>().state.hasMore && 
        context.read<ProductsBloc>().state.productsStates != ProductsStates.loadingMore) {
      fetchFilteredProducts();
    }
  }

  void fetchFilteredProducts() {
    context.read<ProductsBloc>().add(AddFilteredProductsSuggestionsEvent(
        mode: FilteredResponseMode.suggestions,
        page: context.read<ProductsBloc>().state.currentPage + 1,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations translations = AppLocalizations.of(context)!;
    final TextStyle? style = theme.textTheme.bodyMedium?.copyWith(color: Colors.black);

    return SizedBox(
      height: size.height,
      width: size.width,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.productsStates == ProductsStates.loading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.productsStates == ProductsStates.error) {
            return Center(child: Text(translations.error, style: style,));
          }

          return GridView.builder(
            controller: _scrollController,
              itemCount:state.hasMore
                      ? state.filteredProductsSuggestions.length + 1
                      : state.filteredProductsSuggestions.length,
              itemBuilder: (context, index) {
                if (index == state.filteredProductsSuggestions.length) {
                  return const Center(child: CircularProgressIndicator.adaptive());
                }
                final FilteredProduct product = state.filteredProductsSuggestions[index];
                return ProductCard(
                  height: size.height, 
                  width: size.width, 
                  product: product, 
                  theme: theme, 
                  translations: translations
                );
              }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6
              ),
            );
        },
      )
    );
  }
}