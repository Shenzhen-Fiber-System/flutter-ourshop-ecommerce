import 'dart:async';
import '../../../ui/pages/pages.dart';
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
    on<AddSelectedCategoryEvent>((event,emit) => emit(state.copyWith(selectedCategory: event.selectedCategory)));
    on<SelectAllCartProductsEvent>(_selectAllCartProducts);
    on<DeselectAllCartProductsEvent>((event, emit) => emit(state.copyWith(cartProducts: state.cartProducts.map((e) => e.copyWith(selected: false)).toList())));
    on<SelectOrDeselectCartProductEvent> (_selectOrDeselectCartProductEvent);
    on<ClearCart>((event, emit) => emit(state.copyWith(cartProducts: [])));
    on<AddCategoryHeaderImagesEvent>((event, emit) => emit(state.copyWith(categoryHeaderImages: event.categoryHeaderImages)));
  }

  FutureOr<void> _selectOrDeselectCartProductEvent(SelectOrDeselectCartProductEvent event, Emitter<ProductsState> emit){
    final List<Product> updatedList = List.from(state.cartProducts);
    final index = updatedList.indexOf(event.product);
    if(index != -1){
      updatedList[index] = event.product.copyWith(selected: !event.product.selected);
    }
    emit(state.copyWith(cartProducts: updatedList));
  }

  FutureOr<void> _selectAllCartProducts(event, emit) {
    final List<Product> updatedList = List.from(state.cartProducts);
    // for (final product in updatedList) {
    //   product.copyWith(selected: true);
    // }
    for (var i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(selected: true);
    }
    emit(state.copyWith(cartProducts: updatedList));
  }

  FutureOr<void> _removeCartProduct(RemoveCartProductEvent event, Emitter<ProductsState> emit){
    final List<Product> cartProducts = List.from(state.cartProducts);
    final index = cartProducts.indexWhere((element) => element.id == event.product.id);
    if(index != -1){
      final updatedProduct = cartProducts[index].copyWith(quantity: cartProducts[index].quantity - 1);
      if(updatedProduct.quantity == 0){
        cartProducts.removeAt(index);
      }else{
        cartProducts[index] = updatedProduct;
      }
      emit(state.copyWith(cartProducts: cartProducts));
    }
  }

  FutureOr<void> _addCartProduct(AddCartProductEvent event, Emitter<ProductsState> emit){
    final List<Product> cartProducts = List.from(state.cartProducts);
     if (!cartProducts.any((p) => p.id == event.product.id)) {
      cartProducts.add(event.product);
      emit(state.copyWith(cartProducts: cartProducts));
    }
    // if the product is in the cart increment de quantity of the product
    final index = cartProducts.indexWhere((element) => element.id == event.product.id);
    if(index != -1){
      final updatedProduct = cartProducts[index].copyWith(quantity: cartProducts[index].quantity + 1);
      cartProducts[index] = updatedProduct;
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

  Future<List<Product>> getProductsByCategory(String selectedCategory) async {
    add(const AddIsLoadingProdEvent(true));
    final products = await _productService.getProductsByCategory(selectedCategory);
    add(const AddIsLoadingProdEvent(false));
    if (products is List<Product>){
      getHeaderImages(products);
      return products;
    } 
    return [];
  }

  void changeGridCount(int gridCount) => add(ChangeGridCountEvent(gridCount));

  void addFavoriteProduct(Product product) => add(AddFavoriteProductEvent(product));
  
  void addSelectedCategory(String selectedCategory) => add(AddSelectedCategoryEvent(selectedCategory: selectedCategory));

  void addCartProduct(Product product) => add(AddCartProductEvent(product));

  void removeCartProduct(Product product) => add(RemoveCartProductEvent(product));  

  void selectAllCartProducts() => add(const SelectAllCartProductsEvent());

  void deselectAllCartProducts() => add(const DeselectAllCartProductsEvent());

  void selectOrDeselectCartProduct(Product product) => add(SelectOrDeselectCartProductEvent(product:product));

  void getHeaderImages(List<Product> products){
    final List<String> updatedList = List.from(state.categoryHeaderImages);
    for (var product in products) {
      if (product.productPhotos.isNotEmpty) {
        updatedList.add('${dotenv.env['PRODUCT_URL']}${product.productPhotos.first.photo!.url}');
      }
    }
    add(AddCategoryHeaderImagesEvent(categoryHeaderImages: updatedList));
  }

  double get selectedCartProductsPrice {
    double total = 0.00;
    for (final product in state.cartProducts) {
      if(product.selected){
        total += ((product.unitPrice! * product.quantity));
      }
    }
    return total;
  }

  int get selectedCartProductsCount {
    int count = 0;
    for (final product in state.cartProducts) {
      if(product.selected){
        count++;
      }
    }
    return count;
  }



}
