import 'package:flutter/material.dart';

enum CreditCardType {
  visa(
    "visa",
    "Visa",
    "ic_visa.svg",
    Color(0xFF545454),
    Color(0xFFD2D2D2),
    Color(0xFFFFFFFF),
  ),
  masterCard(
    "masterCard",
    "MasterCard",
    "ic_mastercard.svg",
    Color(0xFF000000),
    Color(0xFF282828),
    Color(0xFFFFFFFF),
  ),
  hiperCard(
    "hiperCard",
    "HipperCard",
    "ic_hipercard.svg",
    Color(0xFFAD2020),
    Color(0xFF3F0202),
    Color(0xFFFFFFFF),
  ),
  americanExpress(
    "americanExpress",
    "Amercan Express",
    "ic_american_express.svg",
    Color(0xFF01398D),
    Color(0xFF011738),
    Color(0xFFFFFFFF),
  ),
  elo(
    "elo",
    "Elo",
    "ic_credit_card.svg",
    Color(0xFF01398D),
    Color(0xFF011738),
    Color(0xFFFFFFFF),
  ),
  discover(
    "discover",
    "Discover",
    "ic_credit_card.svg",
    Color(0xFF01398D),
    Color(0xFF011738),
    Color(0xFFFFFFFF),
  ),
  dinners(
    "dinners",
    "Dinners",
    "ic_credit_card.svg",
    Color(0xFF01398D),
    Color(0xFF011738),
    Color(0xFFFFFFFF),
  ),
  jcb(
    "jcb",
    "Jcb",
    "ic_credit_card.svg",
    Color(0xFF01398D),
    Color(0xFF011738),
    Color(0xFFFFFFFF),
  ),
  undefined(
  "creditCard",
  "Credit Card",
  "ic_credit_card.svg",
  Color(0xFFD0D0D0),
  Color(0x44252424),
  Color(0xFFFFFFFF),
  );

  const CreditCardType(this.id, this.title, this.icon, this.colorPrimary,
      this.colorPrimaryDark, this.colorOnPrimary);

  final String id;
  final String title;
  final String icon;
  final Color colorPrimary;
  final Color colorPrimaryDark;
  final Color colorOnPrimary;
}
