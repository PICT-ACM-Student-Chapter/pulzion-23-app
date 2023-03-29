part of 'payment_page_cubit_cubit.dart';

@immutable
abstract class PaymentPageCubitState {}

class PaymentPageCubitInitial extends PaymentPageCubitState {}

class PaymentPageCubitLoading extends PaymentPageCubitState {}

class PaymentPageCubitSuccess extends PaymentPageCubitState {}

class PaymentPageCubitFailure extends PaymentPageCubitState {
  final String message;

  PaymentPageCubitFailure(this.message);
}
