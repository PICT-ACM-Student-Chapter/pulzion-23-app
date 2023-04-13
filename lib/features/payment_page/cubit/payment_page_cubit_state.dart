part of 'payment_page_cubit_cubit.dart';



@immutable
abstract class PaymentPageCubitState {}

class PaymentPageCubitInitial extends PaymentPageCubitState {}

class PaymentPageCubitLoading extends PaymentPageCubitState {}



class PaymentPageCubitSuccess extends PaymentPageCubitState {
  

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

} 

class PaymentPageCubitError extends PaymentPageCubitState{
  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }
  
}

class PaymentPageCubitFailure extends PaymentPageCubitState {
  final String message;

  PaymentPageCubitFailure(this.message);
}
