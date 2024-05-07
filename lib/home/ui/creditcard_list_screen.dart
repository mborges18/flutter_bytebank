
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/home/model/creditcard_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/dialogs/dialog_information.dart';
import '../../creditcard/ui/creditcard_form_screen.dart';
import '../../util/string/strings.dart';
import '../bloc/creditcard_list_bloc.dart';
import '../bloc/creditcard_list_event.dart';
import '../bloc/creditcard_list_state.dart';
import '../model/credit_card_type.dart';
import 'credit_card_view.dart';

class CreditCardListScreen extends StatefulWidget {
  const CreditCardListScreen({super.key});

  @override
  State<CreditCardListScreen> createState() => _CreditCardListScreenState();
}

class _CreditCardListScreenState extends State<CreditCardListScreen> {

  @override
  void initState() {
    BlocProvider.of<CreditCardListBloc>(context).add(HomeCreditCardsListEvent());
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
      body:  BlocConsumer<CreditCardListBloc, CreditCardListState>(
            listener: (context, state) {
              if(state is CreditCardListStateError) {
                const AlertInformation(
                    title: titleInformation,
                    description: msgErrorUnKnow
                ).showError(context);
              }
            },
            buildWhen: (context, state) {
              return (state is CreditCardListStateLoading) || (state is CreditCardListStateInitial) || (state is CreditCardListStateSuccess);
            },
            builder: (context, state) {
              return  (state is CreditCardListStateLoading) || (state is CreditCardListStateInitial)
                  ? const Center(child: Padding(padding: EdgeInsets.only(top: 0.0), child: CircularProgressIndicator(),))
                  : (state is CreditCardListStateSuccess) && state.list.isNotEmpty
                  ? SingleChildScrollView(
                  child:ListView.builder(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CreditCardItem(
                          isFront: true,
                          status: state.list[index].status,
                          typeCard: CreditCardType.values.byName(state.list[index].flag),
                          nameUser: state.list[index].nameUser,
                          numberCard: state.list[index].number,
                          dateExpiredCard: state.list[index].dateExpire,
                          cvvCard: state.list[index].cvv,
                          expanded: false,
                          deleteClick: () {
                            _delete(state.list[index].rowId, state.list);
                          },
                          editClick: () {
                            _edit(state.list[index].rowId);
                          },
                        );
                      },
                    ),
                    )
                  : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 50,
                          Icons.credit_card_rounded,
                          color: Colors.grey,
                        ),
                        Text("LISTA VAZIA")
                      ],
                    ),
                  );
      }),

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

  void _delete(String id, List<CreditCardModel> list) {
    BlocProvider.of<CreditCardListBloc>(context).add(HomeCreditCardsDeleteEvent(id: id, list: list));
  }

  void _edit(String id) {
    BlocProvider.of<CreditCardListBloc>(context).add(HomeCreditCardsEditEvent(id: id));
  }
}

