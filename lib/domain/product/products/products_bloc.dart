import '../../../ui/pages/pages.dart';
import 'dart:async';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  //Repository
  final ProductService _productService;
  //dependency injection
  final GeneralBloc generalBloc;


  ProductsBloc(
    ProductService productService,
    this.generalBloc
  ) : 
    _productService = productService,
  super(const ProductsState()) {
    on<AddIsLoadingProdEvent>((event, emit)=> emit(state.copyWith(isLoading: event.isLoading)));
    on<AddCategoriesEvent>((event, emit)=> emit(state.copyWith(categories: event.categories)));
    on<AddProductsEvent>((event, emit)=> emit(state.copyWith(products: event.products)));
    on<ChangeGridCountEvent>((event, emit)=> emit(state.copyWith(gridCount: event.gridCount)));
    on<AddFavoriteProductEvent>(_addFavoriteProduct);
    on<AddCartProductEvent>(_addCartProduct);
    on<RemoveCartProductEvent>(_removeCartProduct);
    on<AddSelectedCategoryEvent>((event,emit)=> emit(state.copyWith(selectedCategory: event.selectedCategory)));
  }

  FutureOr<void> _removeCartProduct(RemoveCartProductEvent event, Emitter<ProductsState> emit){
    final List<Product> cartProducts = List.from(state.cartProducts);
    if(cartProducts.contains(event.product)){
      cartProducts.remove(event.product);
      emit(state.copyWith(cartProducts: cartProducts));
    }
  }

  FutureOr<void> _addCartProduct(AddCartProductEvent event, Emitter<ProductsState> emit){
    final List<Product> cartProducts = List.from(state.cartProducts);
    if(!cartProducts.contains(event.product)){
      cartProducts.add(event.product);
      emit(state.copyWith(cartProducts: cartProducts));
    }
  }

  FutureOr<void> _addFavoriteProduct(AddFavoriteProductEvent event, Emitter<ProductsState> emit){
    final List<Product> favoriteProducts = List.from(state.favoriteProducts);
    if(favoriteProducts.contains(event.product)){
      favoriteProducts.remove(event.product);
    }else{
      favoriteProducts.add(event.product);
    }
    emit(state.copyWith(favoriteProducts: favoriteProducts));
  }




  Future<void> getProducts() async {
    add(const AddIsLoadingProdEvent(true));
    final products = await _productService.getProducts();
    if(products is List<Product>) add(AddProductsEvent(products));
    add(const AddIsLoadingProdEvent(false));
  }

  Future<List<Category>> getCategories() async {
    add(const AddIsLoadingProdEvent(true));
    final categories = await _productService.getCategories();
    if(categories is List<Category>) {
      if (state.selectedCategory.isEmpty) {
        add(AddSelectedCategoryEvent(selectedCategory:categories.first.id));
      }
      for (var category in categories) {
        final index = categories.indexOf(category);
        final products = await _productService.getProductsByCategory(category.id);
        final updatedCategory = category.copyWith(products: products);
        categories[index] = updatedCategory;
      }
      add(AddCategoriesEvent(categories));
    }
    add(const AddIsLoadingProdEvent(false));
    return categories;
  }

  Future<void> getProductsByCategory() async {
    add(const AddIsLoadingProdEvent(true));
    final products = await _productService.getProductsByCategory(state.selectedCategory);
    // if(products is List<Product>) add(AddProductsEvent(products));
    add(const AddIsLoadingProdEvent(false));
    return products ?? [];
  }

  // Future<List<Content>> filteredProducts(String uuid) async {
  //   add(const AddIsLoadingProdEvent(true));
  //   final products = await _productService.filtered(uuid);
  //   if (products is Data){
  //     add(AddSelectedCategoryEvent(selectedCategory:products.content.first.id));
  //     add(const AddIsLoadingProdEvent(false));
  //     return products.content;
  //   } 
  //   add(const AddIsLoadingProdEvent(false));
  //   return [];
  // }


  void changeGridCount(int gridCount) => add(ChangeGridCountEvent(gridCount));

  void addFavoriteProduct(Product product) => add(AddFavoriteProductEvent(product));
  
  void addSelectedCategory(String selectedCategory) => add(AddSelectedCategoryEvent(selectedCategory: selectedCategory));



}
