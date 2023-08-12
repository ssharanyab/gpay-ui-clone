import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/bank_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<MakePaymentRequested>((event, emit) {
      emit(PaymentLoading());
      try {
        emit(PaymentRequested(
          selectedBank: event.selectedBank,
          amount: event.amount,
          toAccount: event.toAccount,
        ));
      } catch (e) {
        emit(PaymentFailed(message: e.toString()));
      }
    });
  }
}
