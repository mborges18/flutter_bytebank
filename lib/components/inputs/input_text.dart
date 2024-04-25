import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final String textHint;
  final String textLabel;
  final String? maskType;
  final IconData? iconStart;
  final IconData? iconEnd;
  final bool isToggleSecret;
  final int? maxLength;
  final TextInputType inputType;
  final TextEditingController? controller;
  final Function() onValidatorListener;
  final Function(String?) onTextChangeListener;

  const InputText(
    this.textHint,
    this.textLabel,
     {
    super.key,
    this.maskType,
    this.controller,
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
          text = handlerMaskType('date', text);
          widget.onTextChangeListener(text);
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

  String handlerMaskType(maskType, text) {
    switch (maskType) {
      case 'cep':
        text = maskCustom("#####-###", text);
        //handlerLimitAndText(text, 10);
        return text;
        break;

      case 'phone':
        text = maskCustom("(##) ######-####", text);
        //handlerLimitAndText(text, 19);
        return text;
        break;

      case 'cpf':
        text = maskCustom("###.###.###-##",text);
        //handlerLimitAndText(text, 15);
        return text;
        break;

      case 'date':
        text = maskCustom("##/##/####", text);
        //handlerLimitAndText(text, 11);
        return text;
        break;
    }
    return text;
  }

  String maskCustom(String maskCustom, String text) {
    int i = 0;
    int lastReplaceIndex = -1;
    final filledMask = maskCustom.replaceAllMapped(RegExp(r'#'), (match) {
      if (i >= text.length) {
        return '#';
      }
      lastReplaceIndex = match.start;
      return text[i++];
    });
    print(filledMask.substring(0, lastReplaceIndex + 1));
    return filledMask.substring(0, lastReplaceIndex + 1);
  }

  void handlerLimitAndText(text, limit){
  widget.onTextChangeListener(text);
  //text.length < limit ? setDigit(text) : '';
  }
}
