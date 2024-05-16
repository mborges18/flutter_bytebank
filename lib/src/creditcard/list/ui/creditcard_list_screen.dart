import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/dialogs/dialog_information.dart';
import '../../../../util/string/strings.dart';
import '../../../../util/transfer_object.dart';
import '../../form/model/creditcard_form_model.dart';
import '../bloc/creditcard_list_bloc.dart';
import '../bloc/creditcard_list_event.dart';
import '../bloc/creditcard_list_state.dart';
import '../model/creditcard_model.dart';
import 'creditcard_list_accordion.dart';

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
        title: const Text(titleApp),
      ),
      body:  BlocConsumer<CreditCardListBloc, CreditCardListState>(
            listener: (context, state) async {
              if(state is CreditCardListStateError) {
                 AlertInformation(
                    title: titleInformation,
                    description: msgErrorUnKnow
                ).showError(context);
              } else if(state is CreditCardListEditStateSuccess) {
                print("--------------------UPDATE WAIT RESULT pushNamed");
                final result = await Navigator.pushNamed(context, '/form', arguments: {'edit': state.model as dynamic },);
                print("--------------------UPDATE RESULT $result");
                if(result is FilledData) {
                  setState(() {
                    print("--------------------UPDATE SAVE STATE ${ result.object }");
                    CreditCardModel model = CreditCardModel.initObject();
                    model = model.toModel(result.object as CreditCardFormModel);
                    var index = _listModel.indexWhere((data) => data.rowId == model.rowId);
                    _closeAllCard();
                    model.isOpen = true;
                    _listModel.removeAt(index);
                    _listModel.insert(index, model);
                  });
                }
              } else if(state is CreditCardListStateDeleteConfirm) {
                AlertInformation(
                    title: titleInformation,
                    description: msgConfirmDelete
                ).showConfirm(context, (){
                  _delete(false, state.id, state.list);
                });
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
                    child: CreditCardListAccordion(
                    listModel: _listModel,
                    editClick: (rowId, list) {
                      _edit(rowId, list);
                    },
                    deleteClick: (rowId, list) {
                      _delete(true, rowId, list);
                    },
                    cardClick: (bool isOpen, int index, CreditCardModel item) {
                      setState(() {
                        _closeAllCard();
                        _listModel[index].isOpen = !isOpen;
                      });
                    },
                  ))
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
          print("--------------------CREATE WAIT result pushNamed");
          final result = await Navigator.pushNamed(context, '/form');
          print("--------------------CREATE result $result");
          if(result is FilledData) {
            setState(() {
              print("--------------------CREATE result ${ result.object }");
              CreditCardModel model = CreditCardModel.initObject();
              model = model.toModel(result.object as CreditCardFormModel);
              _closeAllCard();
              model.isOpen = true;
              _listModel.insert(0, model);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _closeAllCard() {
    for (var element in _listModel) {
      element.isOpen = false;
    }
  }

  void _delete(bool isConfirm, String id, List<CreditCardModel> list) {
    BlocProvider.of<CreditCardListBloc>(context).add(HomeCreditCardsDeleteEvent(isConfirm: isConfirm, id: id, list: list));
  }

  void _edit(String id, List<CreditCardModel> list) {
    BlocProvider.of<CreditCardListBloc>(context).add(HomeCreditCardsEditEvent(id: id, list: list));
  }
}

