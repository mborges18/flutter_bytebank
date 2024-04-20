import 'package:flutter/material.dart';

class InputTextForm extends StatefulWidget {
  final String textHint;
  final String textLabel;
  final IconData? iconStart;
  final IconData? iconEnd;
  final bool isToggleSecret;
  final int maxLength;
  final TextEditingController controller;
  final Function() onValidatorListener;
  final Function() onTextChangeListener;
  final Function()? onIconEndClickListener;

  const InputTextForm(this.textHint, this.textLabel, this.controller,
      {super.key,
      this.iconStart,
      this.iconEnd,
      this.isToggleSecret = false,
      this.maxLength = 55,
      required this.onValidatorListener,
      required this.onTextChangeListener,
      this.onIconEndClickListener});

  @override
  InputTextFormCustom createState() {
    return InputTextFormCustom();
  }
}

class InputTextFormCustom extends State<InputTextForm> {

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
      child: TextFormField(
        maxLength: widget.maxLength,
        obscureText: widget.isToggleSecret,
        //autovalidateMode: AutovalidateMode.always,
        controller: widget.controller,
        onChanged: (text) {
          widget.onTextChangeListener();
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.textHint,
            labelText: widget.textLabel,
            prefixIcon: Icon(widget.iconStart),
            suffixIcon: IconButton(
              onPressed: () {
                  setState(() {
                    isToggleSecretVisible = !isToggleSecretVisible;
                  });
                  widget.onIconEndClickListener!();
              },
              icon: Icon(isToggleSecret())
            )
        ),
        onSaved: (value) {},
        validator: (value) {
          return widget.onValidatorListener();
        },
      ),
    );
  }
}
