import 'package:curie_assignemnt/models/bank_model.dart';
import 'package:curie_assignemnt/pages/third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_keyboard.dart';

class SecondPage extends StatefulWidget {
  final BankModel selectedBank;
  final String amount;
  final String toName;
  final String toAccount;
  const SecondPage({
    Key? key,
    required this.selectedBank,
    required this.amount,
    required this.toName,
    required this.toAccount,
  }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool passwordVisible = false;

  late PinInputController pinInputController;

  @override
  void initState() {
    super.initState();
    pinInputController =
        PinInputController(length: widget.selectedBank.pin.toString().length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              widget.selectedBank.bankName,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/upi_logo.png',
                ),
              ),
            ],
            toolbarHeight: 80,
            elevation: 0,
          ),
          body: Column(
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue[900],
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        widget.toName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RichText(
                          text: TextSpan(
                            text: '₹ ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            children: [
                              TextSpan(
                                text: widget.amount,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const WidgetSpan(
                                child: SizedBox(
                                  width: 10,
                                ),
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  child: const Icon(
                                    CupertinoIcons.chevron_down,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enter UPI PIN',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                    TextButton.icon(
                      label: passwordVisible
                          ? Text(
                              'SHOW',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 16,
                              ),
                            )
                          : Text(
                              'HIDE',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 16,
                              ),
                            ),
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      icon: AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        transitionBuilder: (child, anim) => FadeTransition(
                          opacity: anim,
                          child: FadeTransition(opacity: anim, child: child),
                        ),
                        child: passwordVisible
                            ? Icon(
                                Icons.visibility,
                                key: const ValueKey('icon1'),
                                color: Colors.blue[900],
                              )
                            : Icon(
                                Icons.visibility_off,
                                key: const ValueKey('icon2'),
                                color: Colors.blue[900],
                              ),
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomKeyboard(
                passwordVisible: passwordVisible,
                pinInputController: pinInputController,
                onSubmit: () {
                  /// ignore: avoid_print
                  validatePin(pinInputController.text);
                  // print("Text is : " + pinInputController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validatePin(String text) {
    if (text == widget.selectedBank.pin.toString()) {
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
              child: ThirdPage(
                amount: widget.amount,
                toName: widget.toName,
                toAccount: widget.toAccount,
              ),
            );
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect PIN'),
        ),
      );
    }
  }
}
