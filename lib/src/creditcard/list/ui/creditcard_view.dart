import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../util/string/strings.dart';
import '../bloc/creditcard_list_bloc.dart';
import '../bloc/creditcard_list_state.dart';
import '../model/credit_card_type.dart';

class CreditCardItem extends StatelessWidget {
  final String status;
  final String numberCard;
  final String nameUser;
  final String dateExpiredCard;
  final String cvvCard;
  final CreditCardType typeCard;
  final bool isFront;
  final bool isClickable;
  bool isOpen;
  final Function()? editClick;
  final Function()? deleteClick;
  final Function(bool, String)? cardClick;

  CreditCardItem({
    super.key,
    required this.status,
    required this.numberCard,
    required this.nameUser,
    required this.dateExpiredCard,
    required this.cvvCard,
    required this.typeCard,
    required this.isFront,
    required this.isClickable,
    required this.isOpen,
    this.editClick,
    this.deleteClick,
    this.cardClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: BlocConsumer<CreditCardListBloc, CreditCardListState>(
          listener: (context, state) {
            (state is CreditCardListEditStateSuccess) ? () {
              Navigator.pushNamed(context, "form", arguments: state.model);
            } : {};
          },
          builder: (context, state) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isClickable) {
                      //_updateHeight();
                    }
                    cardClick?.call(isOpen, numberCard);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: !isOpen ? 70.0 : 210.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: const Alignment(0.5, 4),
                        colors: <Color>[
                          typeCard.colorPrimary,
                          typeCard.colorPrimaryDark,
                        ],
                        tileMode: TileMode.mirror,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(8.0),
                        topRight: const Radius.circular(8.0),
                        bottomLeft: Radius.circular(!isOpen ? 0.0 : 8.0),
                        bottomRight: Radius.circular(!isOpen ? 0.0 : 8.0),
                      ),
                      color: typeCard.colorPrimary,
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
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: isFront ? _frontCard() : _backCard(context),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Visibility(visible: isOpen==true && editClick != null && deleteClick != null,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Ink(
                            decoration: ShapeDecoration(
                              color: (state is CreditCardListDeleteStateLoading)
                                  && state.number == numberCard
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),
                            ),
                            child: (state is CreditCardListDeleteStateLoading)
                                && state.number == numberCard
                                ? const CircularProgressIndicator()
                                : IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.white,
                                    onPressed: () => deleteClick?.call(),
                                  ),
                          ),
                          Ink(
                            decoration: ShapeDecoration(
                              color: (state is CreditCardListEditStateLoading)
                                  && state.number == numberCard
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.primary,
                              shape: const CircleBorder(),
                            ),
                            child: (state is CreditCardListEditStateLoading)
                                && state.number == numberCard
                                ? const CircularProgressIndicator()
                                : IconButton(
                                    icon: const Icon(Icons.edit),
                                    color: Colors.white,
                                    onPressed: () => editClick?.call(),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  String getNumber(String value, int index) {
    try {
      return value.split(" ")[index];
    } catch (e) {
      return "";
    }
  }

  Widget rowFrontTop() {
    return Row(
      children: [
        Text(
          typeCard.title,
          style: textNumberCreditCard(Colors.white, 18, 1.0, true),
        ),
        const Spacer(),
        //const Image(image: AssetImage('assets/ic_credit_card.png'), height: 50, width: 50,),
        SvgPicture.asset(
          typeCard.icon,
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
          getNumber(numberCard, 0),
          style: textNumberCreditCard(Colors.white, 18, 4.0, true),
        ),
        const Spacer(),
        Text(
          getNumber(numberCard, 1),
          style: textNumberCreditCard(Colors.white, 18, 4.0, true),
        ),
        const Spacer(),
        Text(
          getNumber(numberCard, 2),
          style: textNumberCreditCard(Colors.white, 18, 4.0, true),
        ),
        const Spacer(),
        Text(
          getNumber(numberCard, 3),
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
              nameUser,
              style: textNumberCreditCard(Colors.white, 14, 1.0, true),
            ),
            const Spacer(),
            Text(
              dateExpiredCard,
              style: textNumberCreditCard(Colors.white, 14, 1.0, true),
            ),
          ],
        )
      ],
    );
  }

  Widget rowBackTop(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0,
          color: Colors.black54,
          padding: const EdgeInsets.only(bottom: 20.0),
        ),
        const SizedBox(height: 20.0),
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            cvvCard,
            style: textNumberCreditCard(Colors.black, 14, 1.0, false),
          ),
        ),
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

  Widget _backCard(BuildContext context) {
    return rowBackTop(context);
  }

  static TextStyle textNumberCreditCard(
          Color color, double size, double letterSpacing, bool hasShadow) =>
      TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: letterSpacing,
        shadows: hasShadow
            ? [
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
              ]
            : [],
      );
}
