import 'dart:async';
import 'dart:developer';
import 'package:ourshop_ecommerce/models/models.dart';

import '../../../ui/pages/pages.dart';
part 'products_event.dart';
part 'products_state.dart';
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  final ProductService _productService;
  final CategoryService _categoryService;


  ProductsBloc(
    ProductService productService,
    CategoryService categoryService,
  ) : 
    _productService = productService,
    _categoryService = categoryService,
  super(const ProductsState()) {
    on<AddProductsStatesEvent>((event, emit)=> emit(state.copyWith(productsStates: event.productsState)));
    on<AddCategoriesEvent>((event, emit) async  {
      try {  
        emit(state.copyWith(productsStates: ProductsStates.loading));
        final dynamic categories = await _productService.getCategories();
        if (categories is List<Category> && categories.isNotEmpty) {
          emit(state.copyWith(
            categories: [state.categories.first, ...categories], 
            productsStates: ProductsStates.loaded,
            parentCategoryLoaded: true
          ));
        }
      } catch (e) {
        log('error -> AddCategoriesEvent: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<AddProductsEvent>((event, emit)=> emit(state.copyWith(products: event.products)));
    on<ChangeGridCountEvent>((event, emit)=> emit(state.copyWith(gridCount: event.gridCount)));
    on<AddFavoriteProductEvent>(_addFavoriteProduct);
    on<AddCartProductEvent>(_addCartProduct);
    on<RemoveCartProductEvent>(_removeCartProduct);
    on<AddSelectedParentCategoryEvent>((event,emit) {
        final List<Category> updatedCategories = state.categories.map((category) {
          if (category.id == event.selectedParentCategory) {
            // Limpia los productos de la categoría seleccionada
            return category.copyWith(products: []);
          }
          return category; // Mantiene las otras categorías sin modificar
        }).toList();

        // Emitir el estado con la categoría seleccionada, productos vacíos solo en la categoría seleccionada y resetear la página
        emit(state.copyWith(
          selectedParentCategory: event.selectedParentCategory,
          currentPage: 0,
          categories: updatedCategories,
        ));

        // Llama al evento para cargar los productos de la categoría seleccionada
        // add(AddFilteredProductsEvent(
        //   page: state.currentPage + 1,
        //   mode: FilteredResponseMode.generalCategoryProducts,
        //   categoryId: event.selectedParentCategory,
        // ));
    });
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
        emit(state.copyWith(
          productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore,
        ));
        filteredParamenters['uuids'].add({"fieldName":"company.id", "value":event.uuid});
        filteredParamenters['page'] = event.page;
        filteredParamenters['pageSize'] = 10;
        final adminProducts = await _productService.filteredAdminProducts(filteredParamenters);
        if(adminProducts is FilteredData){
          final List<FilteredProduct> updatedList = List.from(state.adminProducts);
          updatedList.addAll(adminProducts.content as List<FilteredProduct>);
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
          final List<FilteredProduct> updatedList = List.from(state.adminProducts);
          updatedList.removeWhere((element) => element.id == event.productId);
          emit(state.copyWith(adminProducts: updatedList));
        }
    });
    on<AddFilteredProductsSuggestionsEvent>((event, emit) async {
      try {
        log('page: ${event.page}');
        emit(state.copyWith(
          productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore,
        ));
        filteredParamenters['uuids'].add({"fieldName":"products", "value":""});
        filteredParamenters['page'] = event.page == 0 ? 1 : event.page;
        filteredParamenters['pageSize'] = 10;
        final response = await  _productService.filteredProducts(filteredParamenters);
        if (response is FilteredData){
          final List<FilteredProduct> updatedSuggestionsList = List.from(state.filteredProductsSuggestions);
          updatedSuggestionsList.addAll(response.content as List<FilteredProduct>);
          emit(state.copyWith(
              filteredProductsSuggestions: updatedSuggestionsList,
              currentPage: event.page,
              hasMore: response.page < response.totalPages,
              productsStates: ProductsStates.loaded
            )
          );
        }
        emit(state.copyWith(productsStates: ProductsStates.loaded));
      } catch (e) {
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<AddFilteredBuildResultsEvent>((event, emit) async {
      try {
        log('page: ${event.page}');
        emit(state.copyWith(
          productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore,
        ));
        filteredParamenters['uuids'].add({"fieldName":"products", "value":""});
        filteredParamenters['searchFields'].add({"fieldName":"name", "value":""});
        filteredParamenters['page'] = event.page == 0 ? 1 : event.page;
        filteredParamenters['pageSize'] = 10;
        filteredParamenters['searchString'] = event.query;
        final response = await  _productService.filteredProducts(filteredParamenters);
        if (response is FilteredData){
          final List<FilteredProduct> updatedBuildResultList = List.from(state.filteredBuildResults);
          updatedBuildResultList.addAll(response.content as List<FilteredProduct>);
          emit(state.copyWith(
              filteredBuildResults: updatedBuildResultList,
              currentPage: response.page,
              hasMore: response.page < response.totalPages,
              productsStates: ProductsStates.loaded
            )
          );
        }
        emit(state.copyWith(productsStates: ProductsStates.loaded));
      } catch (e) {
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<ResetStatesEvent>((event, emit) => emit(state.copyWith(
         currentPage: 0, 
         filteredBuildResults: [], 
         filteredProductsSuggestions: [],
         
       )
      )
    );
    on<AddFilteredProductsEvent>((event, emit) async{
      try {
        // Emitir el estado de carga dependiendo de si es la primera página o una adicional
        emit(state.copyWith(
          productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore,
        ));

        // Configurar los parámetros filtrados, como uuids, page y pageSize
        filteredParamenters['uuids'] = [];
        filteredParamenters['uuids'].add({"fieldName":"products", "value":""});
        filteredParamenters['page'] = event.page;
        filteredParamenters['pageSize'] = 10;

        // Llamada al servicio para obtener los productos filtrados
        final dynamic response =  await _productService.filteredProducts(filteredParamenters);

        if (response is FilteredData) {
          // Obtener la categoría actual, ya sea la principal o la subcategoría
          final Category currentCategory = event.mode == FilteredResponseMode.generalCategoryProducts
              ? state.categories.firstWhere((element) => element.id == state.selectedParentCategory)
              : state.subCategories.firstWhere((element) => element.id == state.selectedSubCategory.id);

          // Obtener el índice de la categoría actual en la lista de categorías
          final int index = state.categories.indexWhere((category) => category.id == currentCategory.id);

          // Actualizar la lista de productos de la categoría agregando los productos nuevos
          final List<FilteredProduct> updatedCategoryProducts = List<FilteredProduct>.from(currentCategory.products)
            ..addAll(response.content as List<FilteredProduct>);

          // Crear una categoría actualizada con los nuevos productos
          final Category updatedCategory = currentCategory.copyWith(products: updatedCategoryProducts);

          // Actualizar la lista de categorías en el estado del Bloc
          final List<Category> updatedCategories = List<Category>.from(state.categories)
            ..[index] = updatedCategory;

          // Determinar si es la última página
          final bool isLastPage = response.page >= response.totalPages;

          // Emitir el nuevo estado con la lista de categorías actualizada y si hay más páginas
          emit(state.copyWith(
            categories: updatedCategories,
            currentPage: event.page,
            hasMore: !isLastPage, // Si es la última página, no hay más páginas
            productsStates: ProductsStates.loaded,
          ));
        } else {
          log('else filtered products error: ');
          emit(state.copyWith(productsStates: ProductsStates.error));
        }
      
      } catch (e) {
        log('catch filtered products error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
      // try {
      //   log('page: ${event.page}');
      //   emit(state.copyWith(
      //     productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore,
      //   ));
      //   filteredParamenters['uuids'] = [];
      //   // filteredParamenters['uuids'].add({"fieldName":"category.id", "value":event.mode == FilteredResponseMode.subCategoryProducts ? state.selectedSubCategory.id : state.selectedParentCategory});
      //   filteredParamenters['uuids'].add({"fieldName":"products", "value":""});
      //   filteredParamenters['page'] = event.page;
      //   // filteredParamenters['page'] = event.page == 0 ? 1 : event.page;
      //   filteredParamenters['pageSize'] = 10;
      //   final dynamic response =  await _productService.filteredProducts(filteredParamenters);

      //   if (response is FilteredData) {
      //     final Category currentCategory = event.mode == FilteredResponseMode.generalCategoryProducts
      //         ? state.categories.firstWhere((element) => element.id == state.selectedParentCategory)
      //         : state.subCategories.firstWhere((element) => element.id == state.selectedSubCategory.id);

      //     final int index = state.categories.indexWhere((category) => category.id == currentCategory.id);

      //     // Copia la categoría actualizada con los nuevos productos
      //     final updatedCategoryProducts = List<FilteredProduct>.from(currentCategory.products);
      //     updatedCategoryProducts.addAll(response.content as List<FilteredProduct>);
      //     final updatedCategory = currentCategory.copyWith(products: updatedCategoryProducts);
          
      //     // Crea una nueva lista de categorías con la categoría actualizada
      //     final updatedCategories = List<Category>.from(state.categories)..[index] = updatedCategory;

      //     emit(state.copyWith(
      //       categories: updatedCategories,
      //       currentPage: event.page,
      //       hasMore: response.page < response.totalPages,  
      //       productsStates: ProductsStates.loaded,
      //     ));
      //   } else {
      //     log('else filtered products error: ');
      //     emit(state.copyWith(productsStates: ProductsStates.error));
      //   }
      
      // } catch (e) {
      //   log('catch filtered products error: ${e.toString()}');
      //   emit(state.copyWith(productsStates: ProductsStates.error));
      // }
        
      
    });
    on<AddFilteredCountriesGrupoEvent>((event, emit) async {

      try {
        emit(state.copyWith(
          productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore,
        ));

        filteredParamenters['uuids'].add({"fieldName":"company.id", "value":event.companyId});
        filteredParamenters['page'] = event.page;
        filteredParamenters['pageSize'] = 10;
        final response = await _productService.filteredCountriesGroup(filteredParamenters);
        if (response is FilteredData<FilteredGroupCountries>) {
          final List<FilteredGroupCountries> updatedGroupCountries = List.from(state.groupCountries);
          updatedGroupCountries.addAll(response.content);
          emit(state.copyWith(
              groupCountries: updatedGroupCountries,
              currentPage: response.page,
              hasMore: response.page < response.totalPages,
              productsStates: ProductsStates.loaded
            )
          );
        }
        emit(state.copyWith(productsStates: ProductsStates.loaded));
      } catch (e) {
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<AddNewCountryGroupEvent>((event,emit) async {
      try {  
        emit(state.copyWith(productsStates: ProductsStates.adding));
        await _productService.addNewCountryGroup(event.body);
        emit(state.copyWith(productsStates: ProductsStates.added));
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<UpdateCountryGroupEvent>((event, emit) async {
      try {
        emit(state.copyWith(productsStates: ProductsStates.updating));
        await _productService.updateCountryGroupById(event.countryGroupId, event.body);
        emit(state.copyWith(productsStates: ProductsStates.updated));
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<AddSubCategoriesNewProductEvent>((event, emit) async {
      try {
        // fetch the subcategories of the selected category for add new products but we fetch all necessary data for this form
        emit(state.copyWith(productsStates: ProductsStates.loading));
        final dynamic subCategories = await _categoryService.getSubCategoriesByCategory(event.categoryId);
        final dynamic productGroups = await _productService.getProductGroups();
        final dynamic productTypes = await _productService.getProductsType();
        final dynamic unitMeasurements = await _productService.getUnitMeasurement();
        if (subCategories is List<Category>) {
          emit(state.copyWith(subCategoriesNewProduct: subCategories, productsStates: ProductsStates.loaded));
        }
        if (productGroups is List<ProductGroup>) {
          emit(state.copyWith(productGroups: productGroups));
        }
        if (productTypes is List<ProductType>) {
          emit(state.copyWith(productTypes: productTypes));
        }
        if (unitMeasurements is List<UnitMeasurement>) {
          emit(state.copyWith(unitMeasurements: unitMeasurements));
        }
      } catch (e) {
        log('error: ${e.toString()}');
      }
    });
    on<AddNewProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(productsStates: ProductsStates.adding));
        await _productService.addNewProduct(event.form);
        emit(state.copyWith(productsStates: ProductsStates.added));
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<AddShippingRatesEvent>((event, emit) async {
      try {
        emit(state.copyWith(
          productsStates: event.page == 1 ? ProductsStates.loading : ProductsStates.loadingMore,
        ));
        filteredParamenters['uuids'].add({"fieldName":"company.id", "value":event.companyId});
        filteredParamenters['page'] = event.page;
        final dynamic shippingRates = await _productService.getShippingRates(filteredParamenters);
        if (shippingRates is FilteredData<FilteredShippingRate>) {
          final List<FilteredShippingRate> updatedShippingRates = List.from(state.shippingRates);
          updatedShippingRates.addAll(shippingRates.content);
          emit(state.copyWith(
              shippingRates: updatedShippingRates,
              currentPage: shippingRates.page,
              hasMore: shippingRates.page < shippingRates.totalPages,
              productsStates: ProductsStates.loaded
            )
          );
        }
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<AddCountryGroupsByCompanyEvent>((event, emit) async {
      try {
        emit(state.copyWith(productsStates: ProductsStates.loading));
        final dynamic countryGroups = await _productService.getCountryGroupsByCompany(event.companyId);
        if (countryGroups is List<CountryGroup>) {
          emit(state.copyWith(
            countryGroupsByCompany: countryGroups,
            productsStates: ProductsStates.loaded
          ));
        }
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
    on<AddShippingRateEvent>((event, emit) async {
      try {
        emit(state.copyWith(productsStates: ProductsStates.adding));
        await _productService.addNewShippingRate(event.body);
        emit(state.copyWith(productsStates: ProductsStates.added));
      } catch (e) {
        log('error: ${e.toString()}');
        emit(state.copyWith(productsStates: ProductsStates.error));
      }
    });
  }

  FutureOr<void> _addSubCategoryProductsEvent(event, emit) {
    final List<Product> updatedList = List.from(state.subCategoryProducts);
    updatedList.addAll(event.subCategoryProducts);
    emit(state.copyWith(subCategoryProducts: event.subCategoryProducts));
  }

  FutureOr<void> _selectOrDeselectCartProductEvent(SelectOrDeselectCartProductEvent event, Emitter<ProductsState> emit){
    final List<FilteredProduct> updatedList = List.from(state.cartProducts);
    final index = updatedList.indexOf(event.product);
    if(index != -1){
      updatedList[index] = event.product.copyWith(selected: !event.product.selected);
    }
    emit(state.copyWith(cartProducts: updatedList));
  }

  FutureOr<void> _selectAllCartProducts(event, emit) {
    final List<FilteredProduct> updatedList = List.from(state.cartProducts);
    for (var i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(selected: true);
    }
    emit(state.copyWith(cartProducts: updatedList));
  }

  FutureOr<void> _removeCartProduct(RemoveCartProductEvent event, Emitter<ProductsState> emit){
    final List<FilteredProduct> cartProducts = List.from(state.cartProducts);
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
    final List<FilteredProduct> cartProducts = List.from(state.cartProducts);
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
    final List<FilteredProduct> favoriteProducts = List.from(state.favoriteProducts);
    if(favoriteProducts.contains(event.product)){
      favoriteProducts.remove(event.product);
    }else{
      favoriteProducts.add(event.product);
    }
    emit(state.copyWith(favoriteProducts: favoriteProducts));
  }

  // Future<void> getProducts() async {
  //   add(const AddProductsStatesEvent(productsState: ProductsStates.loading));
  //   final products = await _productService.getProducts();
  //   if(products is List<Product>) add(AddProductsEvent(products));
  //   add(const AddProductsStatesEvent(productsState: ProductsStates.loaded));
  // }

  // Future<List<Category>> getCategories() async {
  //   add(const AddProductsStatesEvent(productsState: ProductsStates.loading));
  //   final categories = await _productService.getCategories();
  //   if(categories is List<Category>) {
  //     if (state.selectedParentCategory.isEmpty) {
  //       add(AddSelectedParentCategoryEvent(selectedParentCategory:categories.first.id));
  //     }
  //     for (var category in categories) {
  //       final index = categories.indexOf(category);
  //       final products = await _productService.getProductsByCategory(category.id);
  //       if (products is List<Product>) {
  //         final updatedCategory = category.copyWith(products: products);
  //         categories[index] = updatedCategory;
  //       }
  //     }
  //     add(AddCategoriesEvent(categories));
  //   }
  //   add(const AddProductsStatesEvent(productsState: ProductsStates.loaded));
  //   return categories;
  // }

  // Future<void> getProductsByCategory(String categoryId) async {
  //   // add(const AddCategoryHeaderImagesEvent(categoryHeaderImages: []));
  //   add(const AddSubCategoryProductsEvent(subCategoryProducts: []));
  //   add(const AddProductsStatesEvent(productsState: ProductsStates.loading));
  //   final products = await _productService.getProductsByCategory(categoryId);
  //   // if(subCategories is List<SubCategory> && subCategories.isNotEmpty){
  //   //   add(AddSubCategoriesEvent(subCategories: subCategories));
  //   // }
  //   if (products is List<Product>) {
  //     // getHeaderImages(products);
  //     //TODO we gonna add the reviews in the model
  //     for (var product in products) {
  //       final reviews = await _productService.getReviewByProduct(product.id);
  //       if (reviews is List<Review>) {
  //         final updatedProduct = product.copyWith(reviews: reviews);
  //         final index = products.indexOf(product);
  //         products[index] = updatedProduct;
  //       }
  //     }
  //     //TODO HEEEREEEEE
  //     // add(AddSubCategoryProductsEvent(subCategoryProducts: products));
  //     add(const AddProductsStatesEvent(productsState: ProductsStates.loaded));
  //   } 
  // }

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
    // await getProductsByCategory(categoryId);
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

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _productService.getProducts();
      if (response is List<Product>) {
        return response;
      } else {
        return [];
      }
    } catch (e) {
      log('error: ${e.toString()}');
      return [];
    }
  }


  Future<List<Review>?> getProductReviews(String productId) async {
    try {
      final response = await _productService.getReviewByProduct(productId);
      if (response is List<Review>) {
        return response;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
  
  // void addSelectedCategory(String selectedCategory) => add(AddSelectedParentCategoryEvent(selectedParentCategory: selectedCategory));

  void selectAllCartProducts() => add(const SelectAllCartProductsEvent());

  void deselectAllCartProducts() => add(const DeselectAllCartProductsEvent());

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
        total += ((product.unitPrice ?? product.fboPriceEnd! * product.quantity));
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
