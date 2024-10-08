part of 'products_bloc.dart';

class ProductsState extends Equatable {

  final bool isLoading;
  final List<Category> categories;
  final List<Product> products;
  final int gridCount;
  final List<Product> favoriteProducts;
  final List<Product> cartProducts;
  final String selectedCategory;
  final List<String> categoryHeaderImages;

  const ProductsState({
    this.isLoading = false,
    this.categories = const [],
    this.products = const [],
    this.gridCount = 2,
    this.favoriteProducts = const [],
    this.cartProducts = const [],
    this.selectedCategory = '',
    this.categoryHeaderImages = const [],
    
  });

  ProductsState copyWith({
    bool? isLoading,
    List<Category>? categories,
    List<Product>? products,
    int? gridCount,
    List<Product>? favoriteProducts,
    List<Product>? cartProducts,
    String? selectedCategory,
    List<String>? categoryHeaderImages,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      gridCount: gridCount ?? this.gridCount,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      cartProducts: cartProducts ?? this.cartProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categoryHeaderImages: categoryHeaderImages ?? this.categoryHeaderImages,
    );
  }
  
  @override
  List<Object> get props => [
    isLoading,
    categories,
    products,
    gridCount,
    favoriteProducts,
    cartProducts,
    selectedCategory,
    categoryHeaderImages,
  ];
}
