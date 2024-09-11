import 'dart:async';
import 'dart:developer';
import 'package:ourshop_ecommerce/models/models.dart';

import '../../../ui/pages/pages.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  //Repository
  final ProductService _productService;
  final CategoryService _categoryService;
  //dependency injection
  final GeneralBloc generalBloc;


  ProductsBloc(
    ProductService productService,
    CategoryService categoryService,
    this.generalBloc
  ) : 
    _productService = productService,
    _categoryService = categoryService,
  super(const ProductsState()) {
    on<AddProductsStatesEvent>((event, emit)=> emit(state.copyWith(productsStates: event.productsState)));
    on<AddCategoriesEvent>((event, emit)=> emit(state.copyWith(categories: event.categories)));
    on<AddProductsEvent>((event, emit)=> emit(state.copyWith(products: event.products)));
    on<ChangeGridCountEvent>((event, emit)=> emit(state.copyWith(gridCount: event.gridCount)));
    on<AddFavoriteProductEvent>(_addFavoriteProduct);
    on<AddCartProductEvent>(_addCartProduct);
    on<RemoveCartProductEvent>(_removeCartProduct);
    on<AddSelectedParentCategoryEvent>((event,emit) => emit(state.copyWith(selectedParentCategory: event.selectedParentCategory)));
    on<AddSelectedSubCategoryEvent>((event,emit) => emit(state.copyWith(selectedSubCategory: event.selectedSubCategory)));
    on<SelectAllCartProductsEvent>(_selectAllCartProducts);
    on<DeselectAllCartProductsEvent>((event, emit) => emit(state.copyWith(cartProducts: state.cartProducts.map((e) => e.copyWith(selected: false)).toList())));
    on<SelectOrDeselectCartProductEvent> (_selectOrDeselectCartProductEvent);
    on<ClearCart>((event, emit) => emit(state.copyWith(cartProducts: [])));
    on<AddCategoryHeaderImagesEvent>((event, emit) => emit(state.copyWith(categoryHeaderImages: event.categoryHeaderImages)));
    on<AddSubCategoryProductsEvent>(_addSubCategoryProductsEvent);
    on<AddSubCategoriesEvent>((event, emit) => emit(state.copyWith(subCategories: event.subCategories)));
    on<AddAdminProductsEvent>((event, emit) async {
      try {
      
        emit(state.copyWith(productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore));

        final Map<String, dynamic> filteredParamenters = {
          "uuids": [ {
              "fieldName":"company.id", 
              "value":event.uuid
            }
          ],
          "searchFields": [],
          "sortOrders": [],
          "page": event.page,
          "pageSize": 10,
          "searchString": ""
      };

        final adminProducts = await _productService.filteredAdminProducts(filteredParamenters);
        if(adminProducts is FilteredData){
          final List<FilteredProducts> updatedList = List.from(state.adminProducts);
          updatedList.addAll(adminProducts.content as List<FilteredProducts>);
          final hasMore = adminProducts.page < adminProducts.totalPages;
          emit(state.copyWith(
              adminProducts: updatedList,
              currentPage: adminProducts.page,
              hasMore: hasMore,
              productsStates: ProductsStates.loaded
            )
          );
        }
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }

    });
    on<DeleteAdminProductEvent>((event, emit) async {
        final value = await _productService.deleteAdminProductById(event.productId);
        if(value is bool && value){
          final List<FilteredProducts> updatedList = List.from(state.adminProducts);
          updatedList.removeWhere((element) => element.id == event.productId);
          emit(state.copyWith(adminProducts: updatedList));
        }
    });
  }

  FutureOr<void> _addSubCategoryProductsEvent(event, emit) {
    final List<Product> updatedList = List.from(state.subCategoryProducts);
    updatedList.addAll(event.subCategoryProducts);
    emit(state.copyWith(subCategoryProducts: event.subCategoryProducts));
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
    add(const AddProductsStatesEvent(productsState: ProductsStates.loading));
    final products = await _productService.getProducts();
    if(products is List<Product>) add(AddProductsEvent(products));
    add(const AddProductsStatesEvent(productsState: ProductsStates.loaded));
  }

  Future<List<Category>> getCategories() async {
    add(const AddProductsStatesEvent(productsState: ProductsStates.loading));
    final categories = await _productService.getCategories();
    if(categories is List<Category>) {
      // Assign first parent category for default
      if (state.selectedParentCategory.isEmpty) {
        add(AddSelectedParentCategoryEvent(selectedParentCategory:categories.first.id));
      }
      for (var category in categories) {
        final index = categories.indexOf(category);
        final products = await _productService.getProductsByCategory(category.id);
        if (products is List<Product>) {
          final updatedCategory = category.copyWith(products: products);
          categories[index] = updatedCategory;
        }
      }
      add(AddCategoriesEvent(categories));
    }
    add(const AddProductsStatesEvent(productsState: ProductsStates.loaded));
    return categories;
  }

  Future<void> getProductsByCategory(String categoryId) async {
    // add(const AddCategoryHeaderImagesEvent(categoryHeaderImages: []));
    add(const AddSubCategoryProductsEvent(subCategoryProducts: []));
    add(const AddProductsStatesEvent(productsState: ProductsStates.loading));
    final products = await _productService.getProductsByCategory(categoryId);
    // if(subCategories is List<SubCategory> && subCategories.isNotEmpty){
    //   add(AddSubCategoriesEvent(subCategories: subCategories));
    // }
    if (products is List<Product>) {
      // getHeaderImages(products);
      //TODO we gonna add the reviews in the model
      for (var product in products) {
        final reviews = await _productService.getReviewByProduct(product.id);
        if (reviews is List<Review>) {
          final updatedProduct = product.copyWith(reviews: reviews);
          final index = products.indexOf(product);
          products[index] = updatedProduct;
        }
      }
      add(AddSubCategoryProductsEvent(subCategoryProducts: products));
      add(const AddProductsStatesEvent(productsState: ProductsStates.loaded));
    } 
  }

  Future<void> fetchSubCategoriesWithProducts(String categoryId) async {
    add(const AddSelectedSubCategoryEvent(selectedSubCategory: Category(id: '', name: '', description: '', parentCategoryId: '')));
    add(const AddSubCategoriesEvent(subCategories: []));
    add(const AddSubCategoryProductsEvent(subCategoryProducts: []));
    add(const AddProductsStatesEvent(productsState: ProductsStates.loading));
    final subCategoryName =await  _categoryService.getCategoryById(categoryId);
    if (subCategoryName is Category) add(AddSelectedSubCategoryEvent(selectedSubCategory: subCategoryName)); 
    final subcateogries = await _categoryService.getSubCategoriesByCategory(categoryId);
    if (subcateogries is List<Category>) {
      add(AddSubCategoriesEvent(subCategories: subcateogries));
    }
    // final products = await _productService.getProductsByCategory(categoryId);
    // if (products is List<Product>) {
    //   add(AddSubCategoryProductsEvent(subCategoryProducts: products));
    // }
    await getProductsByCategory(categoryId);
    add(const AddProductsStatesEvent(productsState: ProductsStates.loaded));
  }

  Future<List<File>> chooseAdminProductPhotos() async {
    try {
      final ImagePicker picker = locator<ImagePicker>();
      final List<XFile> images = await picker.pickMultiImage();
      final List<File> imagePaths = [];
      for (var image in images) {
        imagePaths.add(File(image.path));
      }
      return imagePaths;
    } catch (e) {
      log('error: ${e.toString()}');
      return [];
    }
  }
  Future<List<File>> chooseAdminProductVideos() async {
    try {
      final ImagePicker picker = locator<ImagePicker>();
      final List<XFile> videos = await picker.pickMultipleMedia();
      final List<File> videosResp = [];
      for (var video in videos) {
        videosResp.add(File(video.path));
      }
      return videosResp;
    } catch (e) {
      log('error: ${e.toString()}');
      return [];
    }
  }

  void changeGridCount(int gridCount) => add(ChangeGridCountEvent(gridCount));

  void addFavoriteProduct(Product product) => add(AddFavoriteProductEvent(product));
  
  void addSelectedCategory(String selectedCategory) => add(AddSelectedParentCategoryEvent(selectedParentCategory: selectedCategory));

  void addCartProduct(Product product) => add(AddCartProductEvent(product));

  void removeCartProduct(Product product) => add(RemoveCartProductEvent(product));  

  void selectAllCartProducts() => add(const SelectAllCartProductsEvent());

  void deselectAllCartProducts() => add(const DeselectAllCartProductsEvent());

  void selectOrDeselectCartProduct(Product product) => add(SelectOrDeselectCartProductEvent(product:product));

  void getHeaderImages(List<Product> products){
    final List<String> updatedList = List.from(state.categoryHeaderImages);
    for (var product in products) {
      if (product.photos.isNotEmpty) {
        updatedList.add('${dotenv.env['PRODUCT_URL']}${product.photos.first.url}');
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
