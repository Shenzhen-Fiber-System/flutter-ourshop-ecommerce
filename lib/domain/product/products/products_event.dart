part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class AddIsLoadingProdEvent extends ProductsEvent {
  final bool isLoading;
  const AddIsLoadingProdEvent(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class AddCategoriesEvent extends ProductsEvent {
  final List<Category> categories;
  const AddCategoriesEvent(this.categories);
  @override
  List<Object> get props => [categories];
}

class AddProductsEvent extends ProductsEvent {
  final List<Product> products;
  const AddProductsEvent(this.products);
  @override
  List<Object> get props => [products];
}

class ChangeGridCountEvent extends ProductsEvent {
  final int gridCount;
  const ChangeGridCountEvent(this.gridCount);
  @override
  List<Object> get props => [gridCount];
}

class AddFavoriteProductEvent extends ProductsEvent {
  final Product product;
  const AddFavoriteProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class AddCartProductEvent extends ProductsEvent {
  final Product product;
  const AddCartProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveCartProductEvent extends ProductsEvent {
  final Product product;
  const RemoveCartProductEvent(this.product);
  @override
  List<Object> get props => [product];
}
class AddSelectedCategoryEvent extends ProductsEvent {
  final String selectedCategory;
  const AddSelectedCategoryEvent({required this.selectedCategory});
  @override
  List<Object> get props => [selectedCategory];
}

class SelectAllCartProductsEvent extends ProductsEvent {
  const SelectAllCartProductsEvent();
  @override
  List<Object> get props => [];
}

class DeselectAllCartProductsEvent extends ProductsEvent {
  const DeselectAllCartProductsEvent();
  @override
  List<Object> get props => [];
}

class SelectOrDeselectCartProductEvent extends ProductsEvent {
  final Product product;
  const SelectOrDeselectCartProductEvent({required this.product});
  @override
  List<Object> get props => [product];
}

class ClearCart extends ProductsEvent {
  const ClearCart();
  @override
  List<Object> get props => [];
}


class AddCategoryHeaderImagesEvent extends ProductsEvent {
  final List<String> categoryHeaderImages;
  const AddCategoryHeaderImagesEvent({required this.categoryHeaderImages});
  @override
  List<Object> get props => [categoryHeaderImages];
}

class AddSelectedSubCategoryEvent extends ProductsEvent {
  final String selectedSubCategory;
  const AddSelectedSubCategoryEvent({required this.selectedSubCategory});
  @override
  List<Object> get props => [selectedSubCategory];
}
