part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class MakePaymentRequested extends PaymentEvent {
  final BankModel selectedBank;
  final double amount;
  final String toAccount;

  const MakePaymentRequested({
    required this.selectedBank,
    required this.amount,
    required this.toAccount,
  });
  @override
  List<Object> get props => [selectedBank, amount, toAccount];
}
