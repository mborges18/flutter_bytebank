import 'package:flutter/material.dart';

import 'MaskType.dart';

class InputText extends StatefulWidget {
  final String textHint;
  final String textLabel;
  final MaskType? maskType;
  final IconData? iconStart;
  final IconData? iconEnd;
  final bool isToggleSecret;
  final int? maxLength;
  final TextInputType inputType;
  final Function() onValidatorListener;
  final Function(String?) onTextChangeListener;

  const InputText({
    super.key,
    required this.textHint,
    required this.textLabel,
    this.maskType,
    this.iconStart,
    this.iconEnd,
    this.isToggleSecret = false,
    this.maxLength,
    this.inputType = TextInputType.text,
    required this.onValidatorListener,
    required this.onTextChangeListener,
  });

  @override
  InputTextCustom createState() {
    return InputTextCustom();
  }
}

class InputTextCustom extends State<InputText> {
  bool isToggleSecretVisible = false;
  String newText = "";

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
        controller: TextEditingController.fromValue(TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        )),
        onChanged: (text) {
          _handlerMaskType(text);
        },
        keyboardType: widget.inputType,
        maxLength: widget.maxLength,
        obscureText: widget.isToggleSecret && !isToggleSecretVisible,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.textLabel,
          hintText: widget.textHint,
          errorText: widget.onValidatorListener(),
          prefixIcon: Icon(widget.iconStart),
          suffixIcon: _suffixButton(),
        ),
      ),
    );
  }

  Widget? _suffixButton() {
    return widget.isToggleSecret == true
        ? IconButton(
            onPressed: () {
              setState(() {
                isToggleSecretVisible = !isToggleSecretVisible;
              });
            },
            icon: Icon(isToggleSecret()))
        : null;
  }

  void _handlerMaskType(String text) {
    if(widget.maskType != null) {
      text = text.replaceAll(RegExp('[^0-9]'), '');
      setState(() {
        newText = _handlerApplyMaskType(widget.maskType, text);
      });
      widget.onTextChangeListener(newText);
    } else {
      widget.onTextChangeListener(text);
    }
  }

  String _handlerApplyMaskType(MaskType? maskType, String text) {
    text = maskType != null ? _maskCustom(maskType.value, text) : text;
    return text;
  }

  String _maskCustom(String maskCustom, String text) {
    int i = 0;
    int lastReplaceIndex = -1;
    final filledMask = maskCustom.replaceAllMapped(RegExp(r'#'), (match) {
      if (i >= text.length) {
        return '#';
      }
      lastReplaceIndex = match.start;
      return text[i++];
    });
    return filledMask.substring(0, lastReplaceIndex + 1);
  }
}
