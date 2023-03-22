part of 'cart_page_cubit.dart';

@immutable
abstract class CartPageState {}

class CartPageLoading extends CartPageState {}

class CartPageLoaded extends CartPageState {
  final List<Events> cartList;
  CartPageLoaded({required this.cartList});
}

class CartPageError extends CartPageState {}
