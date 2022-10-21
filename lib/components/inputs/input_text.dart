import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final TextEditingController _controller;
  final String _textLabel;
  final String hintText;
  final int lengthMax;
  final bool isPassword;
  final Function() onTextChange;
  final String? Function() textError;

  InputText(this._textLabel, this.hintText, this._controller, this.textError,
      {this.lengthMax = 55,
      this.isPassword = false,
      required this.onTextChange});

  @override
  InputTextCustom createState() {
    return InputTextCustom();
  }
}

class InputTextCustom extends State<InputText> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: TextField(
        controller: widget._controller,
        onChanged: (text) {
          widget.onTextChange();
        },
        maxLength: widget.lengthMax,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget._textLabel,
            errorText: widget.textError(),
            hintText: widget.hintText),
      ),
    );
  }
}
