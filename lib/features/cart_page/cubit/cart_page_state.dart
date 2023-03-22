part of 'cart_page_cubit.dart';

@immutable
abstract class CartPageState {}

class CartPageLoading extends CartPageState {}

class CartPageLoaded extends CartPageState {
  final EventList cartList;
  CartPageLoaded(this.cartList);
}

class CartPageError extends CartPageState {}
