
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../creditcard/ui/creditcard_form_screen.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../model/credit_card_type.dart';
import 'credit_card_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeListCreditCardsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("ByteBank"),
      ),
      body: SingleChildScrollView(
        child:BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {},
            buildWhen: (context, state) {
              return (state is HomeStateLoading) || (state is HomeStateSuccess);
            },
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (state is HomeStateSuccess) ? state.list.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return CreditCardItem(
                    isFront: true,
                    typeCard: CreditCardType.values.byName((state is HomeStateSuccess) ? state.list[index].flag : ""),
                    nameUser: (state is HomeStateSuccess) ? state.list[index].nameUser : "",
                    numberCard: (state is HomeStateSuccess) ? state.list[index].number : "",
                    dateExpiredCard: (state is HomeStateSuccess) ? state.list[index].dateExpire : "",
                    cvvCard: (state is HomeStateSuccess) ? state.list[index].cvv : "",
                    expanded: false,
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CreditCardFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

