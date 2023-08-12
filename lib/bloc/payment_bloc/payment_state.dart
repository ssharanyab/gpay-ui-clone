part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class PaymentRequested extends PaymentState {
  final BankModel selectedBank;
  final double amount;
  final String toAccount;

  const PaymentRequested({
    required this.selectedBank,
    required this.amount,
    required this.toAccount,
  });

  @override
  List<Object> get props => [selectedBank, amount, toAccount];
}

class PaymentFailed extends PaymentState {
  final String message;

  const PaymentFailed({required this.message});

  @override
  List<Object> get props => [message];
}
