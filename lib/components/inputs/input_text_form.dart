import 'dart:math';

import 'package:flutter/material.dart';

class InputTextForm extends StatefulWidget {
  final String textHint;
  final String textLabel;
  final Icon? icon;
  final TextEditingController _controller;
  final Function() validator;
  final Function() onTextChange;

  const InputTextForm(this.textHint, this.textLabel, this._controller, {super.key, this.icon, required this.validator, required this.onTextChange});

  @override
  InputTextFormCustom createState() {
    return InputTextFormCustom();
  }
}

class InputTextFormCustom extends State<InputTextForm> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: TextFormField(
        //autovalidateMode: AutovalidateMode.always,
        controller: widget._controller,
        onChanged: (text) {
          widget.onTextChange();
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.textHint,
          labelText: widget.textLabel,
          prefixIcon: widget.icon
        ),
        onSaved: (value) {},
        validator: (value) {
          return widget.validator();
        },
      ),
    );
  }
}

