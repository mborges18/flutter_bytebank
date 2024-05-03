import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/string/strings.dart';
import '../model/credit_card_type.dart';

class CreditCardItem extends StatefulWidget {
  const CreditCardItem({
    super.key,
    required this.numberCard,
    required this.nameUser,
    required this.dateExpiredCard,
    required this.typeCard,
    required this.expanded,
  });

  final String numberCard;
  final CreditCardType typeCard;
  final String nameUser;
  final String dateExpiredCard;
  final bool expanded;

  @override
  State<CreditCardItem> createState() => _CreditCardItemState();
}

class _CreditCardItemState extends State<CreditCardItem> {
  double _height = 70.0;
  bool _isExpanded = false;
  double _borderBottom = 0.0;

  @override
  void initState() {
    super.initState();
    if(widget.expanded){
      _updateHeight();
    }
  }

  void _updateHeight() {
    setState(() {
      _height = _isExpanded ? 70.0 : 210.0;
      _borderBottom = _isExpanded ? 0.0 : 8.0;
      _isExpanded = !_isExpanded;
    });
  }

  String getNumber(String value, int index) {
    try {
      return value.split(" ")[index];
    } catch(e) {
      return "";
    }
  }

  Widget rowTop() {
    return Row(
      children: [
        Text(
          widget.typeCard.title,
          style: textNumberCreditCard(18, 1.0),
        ),
        const Spacer(),
        SvgPicture.asset(
          widget.typeCard.icon,
          width: 50.0,
          height: 50.0,
        ),
      ],
    );
  }

  Widget rowMiddle() {
    return Row(
      children: [
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 0),
          style: textNumberCreditCard(18, 4.0),
        ),
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 1),
          style: textNumberCreditCard(18, 4.0),
        ),
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 2),
          style: textNumberCreditCard(18, 4.0),
        ),
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 3),
          style: textNumberCreditCard(18, 4.0),
        ),
        const Spacer(),
      ],
    );
  }

  Widget rowBottom() {
    return Column(
      children: [
         Row(
          children: [
            Text(
              labelName,
              style: textNumberCreditCard(14, 1.0),
            ),
            const Spacer(),
            Text(
              labelValidate,
              style: textNumberCreditCard(14, 1.0),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              widget.nameUser,
              style: textNumberCreditCard(14, 1.0),
            ),
            const Spacer(),
            Text(
              widget.dateExpiredCard,
              style: textNumberCreditCard(14, 1.0),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: GestureDetector(
          onTap: () {
            if(!widget.expanded){
              _updateHeight();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: const Alignment(0.5, 4),
                colors: <Color>[
                  widget.typeCard.colorPrimary,
                  widget.typeCard.colorPrimaryDark,
                ],
                tileMode: TileMode.mirror,
              ),
              borderRadius: BorderRadius.only(
                topLeft:  const Radius.circular(8.0),
                topRight:  const Radius.circular(8.0),
                bottomLeft: Radius.circular(_borderBottom),
                bottomRight: Radius.circular(_borderBottom),
              ),
              color: widget.typeCard.colorPrimary,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics:  const NeverScrollableScrollPhysics(),
                child: Container(
                  padding:  const EdgeInsets.all(16),
                  child: Column(
                  children: [
                    rowTop(),
                    const SizedBox(height: 40.0),
                    rowMiddle(),
                    const SizedBox(height: 20.0),
                    rowBottom(),
                  ],
                ),
                ),
              ),
            ),
          ),
        ));
  }

  static TextStyle textNumberCreditCard(double size, double letterSpacing) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    color: Colors.grey[100],
    letterSpacing: letterSpacing,
    shadows: const [
      Shadow(
        blurRadius: 1.0,
        color: Colors.black,
        offset: Offset(1.0, 1.0),
      ),
      Shadow(
        color: Colors.black12,
        blurRadius: 1.0,
        offset: Offset(1.0, 1.0),
      ),
    ],
  );
}
