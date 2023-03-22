import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pulzion23/constants/models/event_model.dart';

part 'cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  CartPageCubit() : super(CartPageLoading());

  void loadCart() {
    emit(CartPageLoading());
    emit(CartPageLoaded(cartList: []));
  }
}
