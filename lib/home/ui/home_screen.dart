import 'package:flutter/material.dart';

import '../../creditcard/ui/creditcard_form_screen.dart';
import '../model/credit_card_type.dart';
import 'credit_card_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("ByteBank"),
      ),
      body:
      SingleChildScrollView(
        child: ListView(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                CreditCardItem(typeCard: CreditCardType.masterCard, nameUser: "MARCOS PAULO CASTRO", numberCard: "**** **** **** 5698", dateExpiredCard: "02/2025", expanded: false,),
                CreditCardItem(typeCard: CreditCardType.visa, nameUser: "RENATO CASTRO", numberCard: "**** **** **** 7841", dateExpiredCard: "12/2025", expanded: false,),
                CreditCardItem(typeCard: CreditCardType.hiperCard, nameUser: "MARCELA CASTRO", numberCard: "**** **** **** 5788", dateExpiredCard: "10/2025", expanded: false,),
                CreditCardItem(typeCard: CreditCardType.americanExpress, nameUser: "RAFAELA ALINE CASTRO", numberCard: "**** **** **** 1234", dateExpiredCard: "05/2025", expanded: false,),
                CreditCardItem(typeCard: CreditCardType.masterCard, nameUser: "JUNIOR CASTRO", numberCard: "**** **** **** 1458", dateExpiredCard: "04/2025", expanded: false,),
              ],
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreditCardFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
