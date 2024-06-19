import 'package:flutter/material.dart';

enum CreditCardType {
  visa(
    "Visa",
    "assets/ic_visa.svg",
    Color(0xFF545454),
    Color(0xFFD2D2D2),
    Color(0xFFFFFFFF),
  ),
  masterCard(
    "MasterCard",
    "assets/ic_mastercard.svg",
    Color(0xFF000000),
    Color(0xFF282828),
    Color(0xFFFFFFFF),
  ),
  hiperCard(
    "HipperCard",
    "assets/ic_hipercard.svg",
    Color(0xFFAD2020),
    Color(0xFF3F0202),
    Color(0xFFFFFFFF),
  ),
  americanExpress(
    "American Express",
    "assets/ic_american_express.svg",
    Color(0xFF01398D),
    Color(0xFF011738),
    Color(0xFFFFFFFF),
  ),
  elo(
    "Elo",
    "assets/ic_elo.svg",
    Color(0xFF011738),
    Color(0xFF01398D),
    Color(0xFFFFFFFF),
  ),
  discover(
    "Discover",
    "assets/ic_discover.svg",
    Color(0xFF8D4701),
    Color(0xFFEA8524),
    Color(0xFFFFFFFF),
  ),
  diners(
    "Diners",
    "assets/ic_diners.svg",
    Color(0xFF2E6E03),
    Color(0xFF44A124),
    Color(0xFFFFFFFF),
  ),
  jcb(
    "Jcb",
    "assets/ic_jcb.svg",
    Color(0xFF01398D),
    Color(0xFF011738),
    Color(0xFFFFFFFF),
  ),
  undefined(
  "Credit Card",
  "assets/ic_credit_card.svg",
  Color(0xFFD0D0D0),
  Color(0x44252424),
  Color(0xFFFFFFFF),
  );

  const CreditCardType(this.title, this.icon, this.colorPrimary,
      this.colorPrimaryDark, this.colorOnPrimary);

  final String title;
  final String icon;
  final Color colorPrimary;
  final Color colorPrimaryDark;
  final Color colorOnPrimary;
}
