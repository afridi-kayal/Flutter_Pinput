import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class Formatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length <= 3) {
      return oldValue;
    }
    return newValue;
  }
}

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  late final TextEditingController pinController;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController(text: 'Hello');
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: pinController,
      autofillHints: const [AutofillHints.oneTimeCode],
      length: 10,
      toolbarEnabled: false,
      inputFormatters: [Formatter()],
    );
  }
}

class ErrorStateExample extends StatefulWidget {
  const ErrorStateExample({Key? key}) : super(key: key);

  @override
  State<ErrorStateExample> createState() => _ErrorStateExampleState();
}

class _ErrorStateExampleState extends State<ErrorStateExample> {
  bool _hasError = false;

  Future<void> _validate(String value, bool _) async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _hasError = value == '1111');
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      forceErrorState: _hasError,
      onCompleted: _validate,
    );
  }
}
