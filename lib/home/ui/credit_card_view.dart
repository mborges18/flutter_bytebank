import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../util/string/strings.dart';
import '../model/credit_card_type.dart';

class CreditCardItem extends StatefulWidget {
  const CreditCardItem({
    super.key,
    required this.isFront,
    required this.numberCard,
    required this.nameUser,
    required this.dateExpiredCard,
    required this.typeCard,
    required this.cvvCard,
    required this.expanded,
  });

  final bool isFront;
  final String numberCard;
  final CreditCardType typeCard;
  final String nameUser;
  final String dateExpiredCard;
  final String cvvCard;
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

  Widget rowFrontTop() {
    return Row(
      children: [
        Text(
          widget.typeCard.title,
          style: textNumberCreditCard(Colors.white, 18, 1.0, true),
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

  Widget rowFrontMiddle() {
    return Row(
      children: [
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 0),
          style: textNumberCreditCard(Colors.white, 18, 4.0, true),
        ),
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 1),
          style: textNumberCreditCard(Colors.white, 18, 4.0, true),
        ),
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 2),
          style: textNumberCreditCard(Colors.white, 18, 4.0, true),
        ),
        const Spacer(),
        Text(
          getNumber(widget.numberCard, 3),
          style: textNumberCreditCard(Colors.white, 18, 4.0, true),
        ),
        const Spacer(),
      ],
    );
  }

  Widget rowFrontBottom() {
    return Column(
      children: [
         Row(
          children: [
            Text(
              labelName,
              style: textNumberCreditCard(Colors.white, 14, 1.0, true),
            ),
            const Spacer(),
            Text(
              labelValidate,
              style: textNumberCreditCard(Colors.white, 14, 1.0, true),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              widget.nameUser,
              style: textNumberCreditCard(Colors.white, 14, 1.0, true),
            ),
            const Spacer(),
            Text(
              widget.dateExpiredCard,
              style: textNumberCreditCard(Colors.white, 14, 1.0, true),
            ),
          ],
        )
      ],
    );
  }

  Widget rowBackTop() {
    return Column(
      children: [
        Container(height: 50.0, color: Colors.black54, padding: const EdgeInsets.only(bottom: 20.0),),
        const SizedBox(height: 20.0),
        Container(height: 50.0, width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            widget.cvvCard,
            style: textNumberCreditCard(Colors.black, 14, 1.0, false),
        ),),
      ],
    );
  }

  Widget _frontCard() {
    return Column(
        children: [
          rowFrontTop(),
          const SizedBox(height: 40.0),
          rowFrontMiddle(),
          const SizedBox(height: 20.0),
          rowFrontBottom(),
        ],
      );
  }
  Widget _backCard() {
    return rowBackTop();
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
                  child: widget.isFront ? _frontCard() : _backCard(),
              ),
              ),
            ),
          ),
        ));
  }

  static TextStyle textNumberCreditCard(Color color, double size, double letterSpacing, bool hasShadow) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    color: color,
    letterSpacing: letterSpacing,
    shadows: hasShadow ? [
      const Shadow(
        blurRadius: 1.0,
        color: Colors.black,
        offset: Offset(1.0, 1.0),
      ),
      const Shadow(
        color: Colors.black12,
        blurRadius: 1.0,
        offset: Offset(1.0, 1.0),
      ),
    ] : [],
  );
}
