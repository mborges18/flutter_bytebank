import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final TextEditingController _controller;
  final String _textLabel;
  final String hintText;
  final IconData? iconStart;
  final IconData? iconEnd;
  final int maxLength;
  final bool isToggleSecret;
  final String? Function() textError;
  final Function() onTextChangeListener;
  final Function()? onIconEndClickListener;

  const InputText(
      this._textLabel, this.hintText, this._controller, this.textError,
      {super.key,
      this.iconStart,
      this.iconEnd,
      this.maxLength = 55,
      this.isToggleSecret = false,
      required this.onTextChangeListener,
      this.onIconEndClickListener});

  @override
  InputTextCustom createState() {
    return InputTextCustom();
  }
}

class InputTextCustom extends State<InputText> {

  bool isToggleSecretVisible = false;

  IconData? isToggleSecret() {
    if (widget.isToggleSecret) {
      return isToggleSecretVisible == true
          ? Icons.visibility
          : Icons.visibility_off;
    } else {
      return widget.iconEnd;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: TextField(
        controller: widget._controller,
        onChanged: (text) {
          widget.onTextChangeListener();
        },
        maxLength: widget.maxLength,
        obscureText: widget.isToggleSecret,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget._textLabel,
          hintText: widget.hintText,
          errorText: widget.textError(),
          prefixIcon: Icon(widget.iconStart),
          suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isToggleSecretVisible = !isToggleSecretVisible;
                  });
                  widget.onIconEndClickListener!();
                },
                icon: Icon(isToggleSecret()))),
      ),
    );
  }
}
