part of 'mcq2_login_cubit.dart';

abstract class Mcq2_LoginState {}

class Mcq2_LoginInitial extends Mcq2_LoginState {}

class Mcq2_LoginLoading extends Mcq2_LoginState {}

class Mcq2_LoginShowPass extends Mcq2_LoginState {}

class Mcq2_LoginError extends Mcq2_LoginState {
  String error;
  Mcq2_LoginError(this.error);
}

class Mcq2_LoginSuccess extends Mcq2_LoginState {}
