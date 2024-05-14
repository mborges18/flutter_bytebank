
import 'package:flutter/material.dart';

import '../model/credit_card_type.dart';
import '../model/creditcard_model.dart';
import 'creditcard_view.dart';

class CreditCardListAccordion extends StatelessWidget {

  List<CreditCardModel> listModel;
  final Function(String rowId, List<CreditCardModel> listModel)? editClick;
  final Function(String rowId, List<CreditCardModel> listModel)? deleteClick;
  final Function(bool, int, CreditCardModel)? cardClick;

  CreditCardListAccordion({
    super.key,
    required this.listModel,
    this.editClick,
    this.deleteClick,
    this.cardClick,
  });
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listModel.length,
      itemBuilder: (BuildContext context, int index) {
        return CreditCardItem(
          isFront: true,
          status: listModel[index].status,
          typeCard: CreditCardType.values.byName(listModel[index].flag),
          nameUser: listModel[index].nameUser,
          numberCard: listModel[index].number,
          dateExpiredCard: listModel[index].dateExpire,
          cvvCard: listModel[index].cvv,
          isClickable: true,
          isOpen: listModel[index].isOpen,
          deleteClick: () {
            deleteClick?.call(listModel[index].rowId, listModel);
          },
          editClick: () {
            editClick?.call(listModel[index].rowId, listModel);
          },
          cardClick: (isOpen, number) {
            cardClick?.call(isOpen, index, listModel[index]);
          },
        );
      },
    );
  }
}
