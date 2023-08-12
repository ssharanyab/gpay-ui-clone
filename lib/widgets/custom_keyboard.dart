import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinInputController extends ChangeNotifier {
  int length;
  String text;
  PinInputController({required this.length, this.text = ''});

  changeText(String text) {
    this.text = text;
    notifyListeners();
  }
}

class CustomKeyboard extends StatefulWidget {
  final PinInputController pinInputController;
  final Function() onSubmit;
  final bool passwordVisible;

  const CustomKeyboard({
    Key? key,
    required this.pinInputController,
    required this.onSubmit,
    required this.passwordVisible,
  }) : super(key: key);

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  List<int> inputNumbers = [];
  String pin = "";
  String errorText = '';
  bool showDigit = true;
  Timer? digitTimer;
  int lastEnteredIndex = -1;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.pinInputController.length; i++) {
      inputNumbers.add(i);
    }
    widget.pinInputController.addListener(() {
      inputNumbers.clear();
      for (int i = 0; i < widget.pinInputController.length; i++) {
        inputNumbers.add(i);
      }
      setState(() {});
    });
    widget.pinInputController.addListener(() {
      if (widget.pinInputController.text.isNotEmpty) {
        _startTimer();
      }
    });
  }

  void _startTimer() {
    if (lastEnteredIndex >= 0) {
      setState(() {
        showDigit = true;
      });

      if (digitTimer != null && digitTimer!.isActive) {
        digitTimer!.cancel();
      }

      digitTimer = Timer(const Duration(seconds: 1), () {
        setState(() {
          showDigit = false;
        });
      });
    }
  }

  @override
  void dispose() {
    digitTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: inputNumbers.map((e) => inputWidget(e)).toList(),
          ),
        ),
        errorText.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  errorText,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : Container(
                height: 30,
              ),
        const SizedBox(
          height: 150,
        ),
        customKeyboard(),
      ],
    );
  }

  Widget keyboardButtons(String number) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          btnClicked(number);
        },
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.rectangle,
          ),
          child: Text(
            number,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue[900], fontSize: 30),
          ),
        ),
      ),
    );
  }

  void btnClicked(String btnText) {
    if (pin.length < widget.pinInputController.length) {
      setState(() {
        pin = pin + btnText;
        widget.pinInputController.changeText(pin);
        lastEnteredIndex = pin.length - 1;
      });
    }
    if (pin.length >= widget.pinInputController.length) {
      setState(() {
        errorText = '';
      });
    }
  }

  Widget inputWidget(int position) {
    try {
      return Container(
        height: 80,
        width: 50,
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.black,
            width: 2,
          )),
        ),
        child: Center(
            child: Text(
          (position == lastEnteredIndex && !widget.passwordVisible) &&
                  showDigit &&
                  pin[position].isNotEmpty
              ? pin[position]
              : widget.passwordVisible || pin[position].isEmpty
                  ? widget.passwordVisible
                      ? pin[position]
                      : ''
                  : '*',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        )),
      );
    } catch (e) {
      return Container(
        height: 80,
        width: 50,
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.grey,
            width: 2,
          )),
        ),
      );
    }
  }

  Widget customKeyboard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              keyboardButtons("1"),
              keyboardButtons("2"),
              keyboardButtons("3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              keyboardButtons("4"),
              keyboardButtons("5"),
              keyboardButtons("6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              keyboardButtons("7"),
              keyboardButtons("8"),
              keyboardButtons("9"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    if (pin.isNotEmpty) {
                      setState(() {
                        pin = pin.substring(0, pin.length - 1);
                        widget.pinInputController.changeText(pin);
                      });
                    }
                  },
                  icon: Icon(
                    Icons.backspace,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              keyboardButtons("0"),
              Expanded(
                  child: IconButton(
                onPressed: () {
                  if (pin.length >= widget.pinInputController.length) {
                    widget.onSubmit();
                    setState(() {
                      errorText = '';
                    });
                  } else {
                    setState(() {
                      errorText = 'Please Enter Your Pin';
                    });
                  }
                },
                icon: Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: Colors.blue[900],
                  size: 40,
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
