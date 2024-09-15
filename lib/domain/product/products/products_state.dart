part of 'products_bloc.dart';


enum ProductsStates{
  initial,
  loading,
  loaded,
  error,
  loadingMore
}

enum FilteredResponseMode{
  suggestions,
  results,
  filteredProducts,
  generalCategoryProducts,
  subCategoryProducts

}

class ProductsState extends Equatable {

  final ProductsStates productsStates;
  final List<Category> categories;
  final List<Product> products;
  final int gridCount;
  final List<FilteredProduct> favoriteProducts;
  final List<FilteredProduct> cartProducts;
  final String selectedParentCategory;
  final Category selectedSubCategory;
  final List<String> categoryHeaderImages;
  final List<FilteredProduct> subCategoryProducts;
  final List<Category> subCategories;
  final List<FilteredProduct> adminProducts;
  final List<FilteredProduct> suggestions;
  final List<FilteredProduct> filteredProductsSuggestions;
  final int currentPage;
  final bool hasMore;
  final bool parentCategoryLoaded;

  const ProductsState({
    this.productsStates = ProductsStates.initial,
    this.categories = const [
      Category(id: 'all', name: 'All', description: '', parentCategoryId: '', subCategories: [])
    ],
    this.products = const [],
    this.gridCount = 2,
    this.favoriteProducts = const [],
    this.cartProducts = const [],
    this.selectedParentCategory = 'all',
    this.categoryHeaderImages = const [],
    this.selectedSubCategory = const Category(id: '', name: '', description: '', parentCategoryId: ''),
    this.subCategoryProducts = const [],
    this.subCategories = const [],
    this.adminProducts = const [],
    this.currentPage = 0,
    this.hasMore = true,
    this.suggestions = const [],
    this.filteredProductsSuggestions = const [],
    this.parentCategoryLoaded = false
  });

  ProductsState copyWith({
    ProductsStates? productsStates,
    List<Category>? categories,
    List<Product>? products,
    int? gridCount,
    List<FilteredProduct>? favoriteProducts,
    List<FilteredProduct>? cartProducts,
    String? selectedParentCategory,
    List<String>? categoryHeaderImages,
    Category? selectedSubCategory,
    List<FilteredProduct>? subCategoryProducts,
    List<Category>? subCategories,
    List<FilteredProduct>? adminProducts,
    int? currentPage,
    bool? hasMore,
    List<FilteredProduct>? suggestions,
    List<FilteredProduct>? filteredProductsSuggestions,
    bool? parentCategoryLoaded
  }) {
    return ProductsState(
      productsStates: productsStates ?? this.productsStates,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      gridCount: gridCount ?? this.gridCount,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      cartProducts: cartProducts ?? this.cartProducts,
      selectedParentCategory: selectedParentCategory ?? this.selectedParentCategory,
      categoryHeaderImages: categoryHeaderImages ?? this.categoryHeaderImages,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      subCategoryProducts: subCategoryProducts ?? this.subCategoryProducts,
      subCategories: subCategories ?? this.subCategories,
      adminProducts: adminProducts ?? this.adminProducts,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      suggestions: suggestions ?? this.suggestions,
      filteredProductsSuggestions: filteredProductsSuggestions ?? this.filteredProductsSuggestions,
      parentCategoryLoaded: parentCategoryLoaded ?? this.parentCategoryLoaded
    );
  }
  
  @override
  List<Object> get props => [
    productsStates,
    categories,
    products,
    gridCount,
    favoriteProducts,
    cartProducts,
    selectedParentCategory,
    categoryHeaderImages,
    selectedSubCategory,
    subCategoryProducts,
    subCategories,
    adminProducts,
    currentPage,
    hasMore,
    suggestions,
    filteredProductsSuggestions,
    parentCategoryLoaded
  ];
}
