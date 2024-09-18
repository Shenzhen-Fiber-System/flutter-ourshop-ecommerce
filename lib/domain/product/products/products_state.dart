part of 'products_bloc.dart';


enum ProductsStates{
  initial,
  loading,
  loaded,
  error,
  loadingMore,
  uploading,
  uploaded,
  adding,
  added,
  updating,
  updated,
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
  final List<FilteredGroupCountries> groupCountries;
  final List<Category> subCategoriesNewProduct;
  final List<ProductGroup> productGroups;
  final List<ProductType> productTypes;
  final List<UnitMeasurement> unitMeasurements;
  final List<FilteredShippingRate> shippingRates;
  final List<CountryGroup> countryGroupsByCompany;
  final List<FilteredProduct> filteredBuildResults;

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
    this.parentCategoryLoaded = false,
    this.groupCountries = const [],
    this.subCategoriesNewProduct = const [],
    this.productGroups = const [],
    this.productTypes = const [],
    this.unitMeasurements = const [],
    this.shippingRates = const [],
    this.countryGroupsByCompany = const [],
    this.filteredBuildResults = const []
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
    bool? parentCategoryLoaded,
    List<FilteredGroupCountries>? groupCountries,
    List<Category>? subCategoriesNewProduct,
    List<ProductGroup>? productGroups,
    List<ProductType>? productTypes,
    List<UnitMeasurement>? unitMeasurements,
    List<FilteredShippingRate>? shippingRates,
    List<CountryGroup>? countryGroupsByCompany,
    List<FilteredProduct>? filteredBuildResults
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
      parentCategoryLoaded: parentCategoryLoaded ?? this.parentCategoryLoaded,
      groupCountries: groupCountries ?? this.groupCountries,
      subCategoriesNewProduct: subCategoriesNewProduct ?? this.subCategoriesNewProduct,
      productGroups: productGroups ?? this.productGroups,
      productTypes: productTypes ?? this.productTypes,
      unitMeasurements: unitMeasurements ?? this.unitMeasurements,
      shippingRates: shippingRates ?? this.shippingRates,
      countryGroupsByCompany: countryGroupsByCompany ?? this.countryGroupsByCompany,
      filteredBuildResults: filteredBuildResults ?? this.filteredBuildResults
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
    parentCategoryLoaded,
    groupCountries,
    subCategoriesNewProduct,
    productGroups,
    productTypes,
    unitMeasurements,
    shippingRates,
    countryGroupsByCompany,
    filteredBuildResults
  ];
}
