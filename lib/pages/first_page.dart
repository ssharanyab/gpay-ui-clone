import 'package:curie_assignemnt/models/bank_model.dart';
import 'package:curie_assignemnt/pages/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/payment_bloc/payment_bloc.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  // Controller for the amount text field
  final TextEditingController _amtController = TextEditingController();

  // Dummy data for the bank list
  final List<BankModel> bankList = [
    BankModel(
      bankName: 'Bank One',
      bankIcon: Icons.account_balance_wallet,
      bankAccountNumber: '12345678',
      pin: 3456,
    ),
    BankModel(
      bankName: 'Bank Two',
      bankIcon: Icons.savings,
      bankAccountNumber: '87654321',
      pin: 6789,
    ),
    BankModel(
      bankName: 'Bank Three',
      bankIcon: Icons.paid,
      bankAccountNumber: '24681357',
      pin: 123456,
    ),
  ];

  late BankModel selectedBank;

  @override
  void initState() {
    super.initState();
    selectedBank = bankList[0];
  }

  @override
  void dispose() {
    _amtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentRequested) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.ease)),
                  ),
                  child: SecondPage(
                    selectedBank: state.selectedBank,
                    amount: state.amount.toString(),
                    toName: 'Red Bus',
                    toAccount: 'redbus@axis.upi',
                  ),
                );
              },
            ),
          ).then((_) => setState(() {}));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('icon1')
                    ? Tween<double>(begin: 0.75, end: 1).animate(anim)
                    : Tween<double>(begin: 1, end: 0.75).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
              child: MediaQuery.of(context).viewInsets.bottom > 0.0
                  ? const Icon(
                      Icons.arrow_back_rounded,
                      key: ValueKey('icon1'),
                    )
                  : const Icon(
                      Icons.arrow_downward,
                      key: ValueKey('icon2'),
                      color: Colors.transparent,
                    ),
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundImage: const AssetImage(
                          'assets/person.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/redbus_logo.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment to Red Bus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const Text(
                '(redbus@axis)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '\u{20B9}${'  '}',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IntrinsicWidth(
                    child: TextFormField(
                      controller: _amtController,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      minLines: null,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(7),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      keyboardAppearance: Brightness.dark,
                      onEditingComplete: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                        hintText: '0',
                        hintStyle: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Expanded(
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(40),
              //         topRight: Radius.circular(40),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        extendBody: false,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  tileColor: Colors.grey[700],
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  leading: Icon(selectedBank.bankIcon),
                  title: Text(
                    '${selectedBank.bankName} (${selectedBank.bankAccountNumber.replaceFirst(selectedBank.bankAccountNumber.substring(0, selectedBank.bankAccountNumber.length - 4), '****')})',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(CupertinoIcons.chevron_down),
                  onTap: () => _allBanksSheet(context),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (_amtController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter Amount'),
                        ),
                      );
                    } else {
                      makePaymentRequested();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: const Center(
                      child: Text(
                        'Proceed to Pay',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: 'IN PARTNERSHIP WITH ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          bankList[0].bankIcon,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextSpan(
                        text: ' ${bankList[0].bankName.toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _allBanksSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: bankList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(bankList[index].bankIcon),
                title: Text(bankList[index].bankName),
                subtitle: Text(
                  bankList[index].bankAccountNumber.replaceFirst(
                      bankList[index].bankAccountNumber.substring(
                          0, bankList[index].bankAccountNumber.length - 4),
                      '****'),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    letterSpacing: 1.5,
                  ),
                ),
                trailing: const Icon(CupertinoIcons.chevron_right),
                onTap: () {
                  setState(() {
                    selectedBank = bankList[index];
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  void makePaymentRequested() {
    BlocProvider.of<PaymentBloc>(context).add(
      MakePaymentRequested(
        selectedBank: selectedBank,
        amount: double.parse(_amtController.text),
        toAccount: 'Red Bus',
      ),
    );
  }
}
