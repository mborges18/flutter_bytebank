import 'dart:core';

class CreditCardModel {
  String name = "";
  String number = "";
  String date = "";
  String cvv = "";
  int step = 1;

  CreditCardModel({
    required this.name,
    required this.number,
    required this.date,
    required this.cvv,
  });

  Map toJson() => {
    "name": name,
    "date": date,
    "number": number,
    "cvv": cvv,
  };

  String validateCCNum() {
    var ccCheckRegExp = RegExp(r'[^\d\s-]');
    var isValid = !ccCheckRegExp.hasMatch(number);

    if (isValid) {
      final cardNumbersOnly = number.replaceAll(RegExp(r'[\s-]'), '');
      final cardNumberLength = cardNumbersOnly.length;

      final arrCheckTypes = ['mastercard', 'visa', 'amex', 'discover', 'dinners', 'jcb', 'hipercard', 'elo'];
      for (var i = 0; i < arrCheckTypes.length; i++) {
        var lengthIsValid = false;
        var prefixIsValid = false;
        late RegExp prefixRegExp;

        switch (arrCheckTypes[i]) {
          case "mastercard":
            lengthIsValid = (cardNumberLength == 16);
            prefixRegExp = RegExp(r"^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$");
            break;

          case "visa":
            lengthIsValid = (cardNumberLength == 16);
            prefixRegExp = RegExp(r"^4[0-9]{15}?");
            break;

          case "amex":
            lengthIsValid = (cardNumberLength == 15);
            prefixRegExp = RegExp(r"^3[47][0-9]{13}$");
            break;

          case "discover":
            lengthIsValid = (cardNumberLength == 15 || cardNumberLength == 16);
            prefixRegExp = RegExp(r"^6(?:011|5[0-9]{2})[0-9]{12}$");
            break;

          case "dinners":
            lengthIsValid = (cardNumberLength == 14);
            prefixRegExp = RegExp(r"^3(?:0[0-5]|[68][0-9])[0-9]{11}$");
            break;

          case "jcb":
            lengthIsValid = (cardNumberLength == 15 || cardNumberLength == 16);
            prefixRegExp = RegExp(r"^35[0-9]{14}$");
            break;

            case "hipercard":
            lengthIsValid = (cardNumberLength == 16);
            prefixRegExp = RegExp(r'^(606282\d{10}(\d{3})?)|(3841\d{12})|(637\d{13})$');
            break;

            case "elo":
            lengthIsValid = (cardNumberLength == 16);
            prefixRegExp = RegExp(r'(4011|431274|438935|451416|457393|4576|457631|457632|504175|627780|636297|636368|636369|(6503[1-3])|(6500(3[5-9]|4[0-9]|5[0-1]))|(6504(0[5-9]|1[0-9]|2[0-9]|3[0-9]))|(650(48[5-9]|49[0-9]|50[0-9]|51[1-9]|52[0-9]|53[0-7]))|(6505(4[0-9]|5[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-8]))|(6507(0[0-9]|1[0-8]))|(6507(2[0-7]))|(650(90[1-9]|91[0-9]|920))|(6516(5[2-9]|6[0-9]|7[0-9]))|(6550(0[0-9]|1[1-9]))|(6550(2[1-9]|3[0-9]|4[0-9]|5[0-8]))|(506(699|77[0-8]|7[1-6][0-9))|(509([0-9][0-9][0-9])))');

            break;

          default:
            prefixRegExp = RegExp(r'^$');
        }

        prefixIsValid = prefixRegExp.hasMatch(cardNumbersOnly);
        isValid = prefixIsValid && lengthIsValid;

        // Check if we found a correct one
        if (isValid) {
          return arrCheckTypes[i];
        }
      }
    }

    if (!isValid) {
      return "Invalid";
    }

    return "Invalid";
  }
}
