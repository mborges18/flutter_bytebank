
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
}
