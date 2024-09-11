part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class AddProductsStatesEvent extends ProductsEvent {
  final ProductsStates productsState;
  const AddProductsStatesEvent({required this.productsState});
  @override
  List<Object> get props => [productsState];
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
class AddSelectedParentCategoryEvent extends ProductsEvent {
  final String selectedParentCategory;
  const AddSelectedParentCategoryEvent({required this.selectedParentCategory});
  @override
  List<Object> get props => [selectedParentCategory];
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
  final Category selectedSubCategory;
  const AddSelectedSubCategoryEvent({required this.selectedSubCategory});
  @override
  List<Object> get props => [selectedSubCategory];
}

class AddSubCategoryProductsEvent extends ProductsEvent {
  final List<Product> subCategoryProducts;
  const AddSubCategoryProductsEvent({required this.subCategoryProducts});
  @override
  List<Object> get props => [subCategoryProducts];
}

class AddSubCategoriesEvent extends ProductsEvent {
  final List<Category> subCategories;
  const AddSubCategoriesEvent({required this.subCategories});
  @override
  List<Object> get props => [subCategories];
}

class AddAdminProductsEvent extends ProductsEvent {
  final String uuid;
  final int page;
  const AddAdminProductsEvent({required this.uuid, required this.page});
  @override
  List<Object> get props => [uuid, page];
}

class DeleteAdminProductEvent extends ProductsEvent {
  final String productId;
  const DeleteAdminProductEvent({required this.productId});
  @override
  List<Object> get props => [productId];
}
