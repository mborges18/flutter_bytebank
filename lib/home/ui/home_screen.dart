import 'package:flutter/material.dart';

import 'credit_card_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ByteBank"),
      ),
      body:
      SingleChildScrollView(
        child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                CreditCardItem(color: Color(0xFF000000), nameCard: 'MasterCard', nameUser: "MARCOS PAULO CASTRO", numberCard: "**** 5698", dateExpiredCard: "02/2025",),
                CreditCardItem(color: Color(0xFF01398D), nameCard: 'Visa', nameUser: "RENATO CASTRO", numberCard: "**** 7841", dateExpiredCard: "12/2025",),
                CreditCardItem(color: Color(0xFFAD2020), nameCard: 'HipperCard', nameUser: "MARCELA CASTRO", numberCard: "**** 5788", dateExpiredCard: "10/2025",),
                CreditCardItem(color: Color(0xFFEEBA13), nameCard: 'GoldenCard', nameUser: "RAFAELA ALINE CASTRO", numberCard: "**** 1234", dateExpiredCard: "05/2025",),
                CreditCardItem(color: Color(0xFF000000), nameCard: 'MasterCard', nameUser: "JUNIOR CASTRO", numberCard: "**** 1458", dateExpiredCard: "04/2025",),
              ],
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _click,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _click() {}
}
