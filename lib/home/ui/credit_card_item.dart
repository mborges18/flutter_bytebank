import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/string/strings.dart';
import '../../util/theme/styles_constants.dart';

class CreditCardItem extends StatefulWidget {
  const CreditCardItem({
    super.key,
    required this.numberCard,
    required this.nameUser,
    required this.dateExpiredCard,
    required this.typeCard,
  });

  final String numberCard;
  final CreditCardType typeCard;
  final String nameUser;
  final String dateExpiredCard;

  @override
  State<CreditCardItem> createState() => _CreditCardItemState();
}

class _CreditCardItemState extends State<CreditCardItem> {
  double _height = 70.0;
  bool _isExpanded = false;
  double _borderBottom = 0.0;

  void _updateHeight() {
    setState(() {
      _height = _isExpanded ? 70.0 : 210.0;
      _borderBottom = _isExpanded ? 0.0 : 8.0;
      _isExpanded = !_isExpanded;
    });
  }

  Widget rowTop() {
    return Row(
      children: [
        Text(
          widget.typeCard.title,
          style: StylesApp.textMiddleBold(Colors.white),
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
          widget.numberCard.split(" ")[0],
          style: StylesApp.textMiddleBold(Colors.white),
        ),
        const Spacer(),
        Text(
          widget.numberCard.split(" ")[1],
          style: StylesApp.textMiddleBold(Colors.white),
        ),
        const Spacer(),
        Text(
          widget.numberCard.split(" ")[2],
          style: StylesApp.textMiddleBold(Colors.white),
        ),
        const Spacer(),
        Text(
          widget.numberCard.split(" ")[3],
          style: StylesApp.textMiddleBold(Colors.white),
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
              style: StylesApp.textCommonBold(Colors.white),
            ),
            const Spacer(),
            Text(
              labelValidate,
              style: StylesApp.textCommonBold(Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              widget.nameUser,
              style: StylesApp.textCommonBold(Colors.white),
            ),
            const Spacer(),
            Text(
              widget.dateExpiredCard,
              style: StylesApp.textCommonBold(Colors.white),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
        child: GestureDetector(
          onTap: () {
            _updateHeight();
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
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
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
}

enum CreditCardType {
  visa("visa", "Visa", "ic_visa.svg", Color(0xFF545454), Color(0xFFD2D2D2), Color(0xFFFFFFFF)),
  masterCard("masterCard", "MasterCard", "ic_mastercard.svg", Color(0xFF000000), Color(0xFF282828), Color(0xFFFFFFFF)),
  hiperCard(" hiperCard", "HipperCard", "ic_hipercard.svg", Color(0xFFAD2020), Color(
      0xFF3F0202), Color(0xFFFFFFFF)),
  americanExpress("americanExpress", "Amercan Express", "ic_american_express.svg", Color(0xFF01398D), Color(
      0xFF011738), Color(0xFFFFFFFF));

  const CreditCardType(this.id, this.title, this.icon, this.colorPrimary, this.colorPrimaryDark, this.colorOnPrimary);
  final String title;
  final String id;
  final String icon;
  final Color colorPrimary;
  final Color colorPrimaryDark;
  final Color colorOnPrimary;
}
