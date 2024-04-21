import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String textHint;
  final String textLabel;
  final IconData? iconStart;
  final IconData? iconEnd;
  final bool isToggleSecret;
  final int maxLength;
  final TextEditingController? controller;
  final Function() onValidatorListener;
  final Function(String?) onTextChangeListener;
  final Function()? onIconEndClickListener;

  const InputText(this.textHint, this.textLabel,
      {super.key,
      this.controller,
      this.iconStart,
      this.iconEnd,
      this.isToggleSecret = false,
      this.maxLength = 55,
      required this.onValidatorListener,
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
        controller: widget.controller,
        onChanged: (text) {
          widget.onTextChangeListener(text);
        },
        maxLength: widget.maxLength,
        obscureText: widget.isToggleSecret,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.textLabel,
            hintText: widget.textHint,
            errorText: widget.onValidatorListener(),
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
