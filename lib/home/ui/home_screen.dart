
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
            builder: (context, state) {
              return (state is HomeStateSuccess) ? ListView.builder(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return CreditCardItem(
                    isFront: true,
                    typeCard: CreditCardType.values.byName(state.list[index].flag),
                    nameUser: state.list[index].nameUser,
                    numberCard: state.list[index].number,
                    dateExpiredCard: state.list[index].dateExpire,
                    cvvCard: state.list[index].cvv,
                    expanded: false,
                  );
                },
              ) : (state is HomeStateLoading) || (state is HomeStateInitial)
                  ? const Center(child: Padding(padding: EdgeInsets.only(top: 80.0), child: CircularProgressIndicator(),))
                  : const Center(child: Text("Error"),);
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

