import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:upi_india/upi_india.dart';



part 'payment_page_cubit_state.dart';

class PaymentPageCubitCubit extends Cubit<PaymentPageCubitState> {
  PaymentPageCubitCubit() : super(PaymentPageCubitInitial());
  
  Future<void> pay() async {
    emit(PaymentPageCubitLoading());
    try {
      
      // do something
      emit(PaymentPageCubitSuccess());
    } catch (e) {
      emit(PaymentPageCubitFailure(e.toString()));
    }
  }


  
  
}
