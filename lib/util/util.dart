import 'package:flutter/cupertino.dart';


class Util{

  static void closeKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}