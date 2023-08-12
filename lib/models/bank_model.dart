import 'package:flutter/cupertino.dart';

class BankModel {
  String bankName;
  IconData bankIcon;
  String bankAccountNumber;
  int pin;
  BankModel({
    required this.bankName,
    required this.bankIcon,
    required this.bankAccountNumber,
    required this.pin,
  });
}
