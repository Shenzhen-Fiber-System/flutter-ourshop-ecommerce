part of 'products_bloc.dart';


enum ProductsStates{
  initial,
  loading,
  loaded,
  error,
}

class ProductsState extends Equatable {

  final ProductsStates productsStates;
  final List<Category> categories;
  final List<Product> products;
  final int gridCount;
  final List<Product> favoriteProducts;
  final List<Product> cartProducts;
  final String selectedParentCategory;
  final Category selectedSubCategory;
  final List<String> categoryHeaderImages;
  final List<Product> subCategoryProducts;
  final List<Category> subCategories;

  const ProductsState({
    this.productsStates = ProductsStates.initial,
    this.categories = const [],
    this.products = const [],
    this.gridCount = 2,
    this.favoriteProducts = const [],
    this.cartProducts = const [],
    this.selectedParentCategory = '',
    this.categoryHeaderImages = const [],
    this.selectedSubCategory = const Category(id: '', name: '', description: '', parentCategoryId: ''),
    this.subCategoryProducts = const [],
    this.subCategories = const []
    
  });

  ProductsState copyWith({
    ProductsStates? productsStates,
    List<Category>? categories,
    List<Product>? products,
    int? gridCount,
    List<Product>? favoriteProducts,
    List<Product>? cartProducts,
    String? selectedParentCategory,
    List<String>? categoryHeaderImages,
    Category? selectedSubCategory,
    List<Product>? subCategoryProducts,
    List<Category>? subCategories
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
      subCategories: subCategories ?? this.subCategories
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
    subCategories
  ];
}
