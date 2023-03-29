part of 'cart_page_cubit.dart';

@immutable
abstract class CartPageState {}

class CartPageLoading extends CartPageState {}

class CartPageLoaded extends CartPageState {
  final CartItemList cartList;
  CartPageLoaded(this.cartList);
}

class CartEmpty extends CartPageState {}

class CartPageError extends CartPageState {
  final String message;
  CartPageError(this.message);
}

class CartItemAdded extends CartPageState {
  final String message;
  CartItemAdded(this.message);
}

class CartItemNotAdded extends CartPageState {
  final String message;
  CartItemNotAdded(this.message);
}

class CartItemDeleted extends CartPageState {
  final String message;
  CartItemDeleted(this.message);
}

class CartItemNotDeleted extends CartPageState {
  final String message;
  CartItemNotDeleted(this.message);
}

class CartPageReload extends CartPageState {}
