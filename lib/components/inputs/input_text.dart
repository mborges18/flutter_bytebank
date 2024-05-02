import 'package:flutter/material.dart';

import 'MaskType.dart';

class InputText extends StatefulWidget {
  final String textHint;
  final String textLabel;
  final MaskType? maskType;
  String? value;
  final IconData? iconStart;
  final IconData? iconEnd;
  final bool isToggleSecret;
  final int? maxLength;
  final TextInputType inputType;
  final Function() onValidatorListener;
  final Function(String?) onTextChangeListener;

  InputText({
    super.key,
    required this.textHint,
    required this.textLabel,
    this.maskType,
    this.value,
    this.iconStart,
    this.iconEnd,
    this.isToggleSecret = false,
    this.maxLength = 55,
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
  bool isFocused = false;
  bool isError = false;
  //String newText = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
      child: FocusScope(
        child: Focus(
          onFocusChange: (focus) {
            setState(() {
              isFocused = focus;
            });
          },
          child: TextField(
            controller:
                TextEditingController.fromValue(TextEditingValue(
                    text: widget.value ?? "",
                    selection: TextSelection.collapsed(
                        offset:
                            widget.value != null ? widget.value!.length : 0),
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
              counterStyle: const TextStyle(color: Colors.transparent),
              prefixIcon: Icon(
                widget.iconStart,
                color: _handlerColorIcon(),
              ),
              suffixIcon: _suffixButton(),
            ),
          ),
        ),
      ),
    );
  }

  IconData? _isToggleSecret() {
    if (widget.isToggleSecret) {
      return isToggleSecretVisible == true
          ? Icons.visibility
          : Icons.visibility_off;
    } else {
      return widget.iconEnd;
    }
  }

  bool _hasError() {
    return widget.onValidatorListener()!=null;
  }

  Color _handlerColorIcon() {
    var color = Theme.of(context).colorScheme.onSurfaceVariant;
    if(isFocused) {
      color = _hasError() ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary;
    } else {
      color = _hasError() ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onSurfaceVariant;
    }
    return color;
  }

  Widget? _suffixButton() {
    return widget.isToggleSecret == true
        ? IconButton(
            onPressed: () {
              setState(() {
                isToggleSecretVisible = !isToggleSecretVisible;
              });
            },
            icon: Icon(_isToggleSecret()))
        : null;
  }

  void _handlerMaskType(String text) {
    if (widget.maskType != null) {
      text = text.replaceAll(RegExp('[^0-9]'), '');
      setState(() {
        widget.value = _handlerApplyMaskType(widget.maskType, text);
      });
      widget.onTextChangeListener(widget.value);
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
