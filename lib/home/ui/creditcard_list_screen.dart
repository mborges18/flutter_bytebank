
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/home/model/creditcard_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/dialogs/dialog_information.dart';
import '../../creditcard/model/creditcard_form_model.dart';
import '../../util/string/strings.dart';
import '../../util/transfer_object.dart';
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

  List<CreditCardModel> _listModel = [];

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
              } else if(state is CreditCardListEditStateSuccess) {
                Navigator.pushNamed(context, '/form', arguments: {'edit': state.model as dynamic},);

              }
            },
            buildWhen: (context, state) {
              return (state is CreditCardListStateLoading)
                  || (state is CreditCardListStateInitial)
                  || (state is CreditCardListStateSuccess);
            },
            builder: (context, state) {
              (state is CreditCardListStateSuccess) ? _listModel = state.list : _listModel=[];
              return  (state is CreditCardListStateLoading) || (state is CreditCardListStateInitial)
                  ? const Center(child: Padding(padding: EdgeInsets.only(top: 0.0), child: CircularProgressIndicator(),))
                  : (state is CreditCardListStateSuccess) && state.list.isNotEmpty
                  ? SingleChildScrollView(
                  child:ListView.builder(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _listModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CreditCardItem(
                          isFront: true,
                          status: _listModel[index].status,
                          typeCard: CreditCardType.values.byName(_listModel[index].flag),
                          nameUser: _listModel[index].nameUser,
                          numberCard: _listModel[index].number,
                          dateExpiredCard: _listModel[index].dateExpire,
                          cvvCard: _listModel[index].cvv,
                          expanded: false,
                          deleteClick: () {
                            _delete(_listModel[index].rowId, _listModel);
                          },
                          editClick: () {
                            _edit(_listModel[index].rowId, _listModel);
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
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/form');
          if(result is FilledData) {
            setState(() {
              print("--------------------result ${ result.object }");
              CreditCardModel model = CreditCardModel.initObject();
              model = model.toModel(result.object as CreditCardFormModel);
              _listModel.insert(0, model);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _delete(String id, List<CreditCardModel> list) {
    BlocProvider.of<CreditCardListBloc>(context).add(HomeCreditCardsDeleteEvent(id: id, list: list));
  }

  void _edit(String id, List<CreditCardModel> list) {
    BlocProvider.of<CreditCardListBloc>(context).add(HomeCreditCardsEditEvent(id: id, list: list));
  }
}

