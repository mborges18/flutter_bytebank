import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../util/string/strings.dart';
import '../../../../util/transfer_object.dart';
import '../../../../util/util.dart';
import '../../list/model/credit_card_type.dart';
import '../../list/model/creditcard_model.dart';
import '../../list/ui/credit_card_view.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_event.dart';
import '../bloc/creditcard_form_state.dart';
import '../model/creditcard_form_model.dart';
import 'input_buttons.dart';
import 'input_cvv.dart';
import 'input_date.dart';
import 'input_name.dart';
import 'input_number.dart';

class CreditCardFormScreen extends StatefulWidget {
  const CreditCardFormScreen({super.key});

  @override
  State<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  CreditCardFormModel _model = CreditCardFormModel.initObject();
  TransferObject _result = EmptyData();
  String newNumber = maskNumber;
  CreditCardType creditCardType = CreditCardType.undefined;

  @override
  void initState() {
    _handlerResetData();
    super.initState();
  }

  void _handlerEventNumber(String text) {
    setState(() {
      _model.number = text;
      text = maskNumber.replaceRange(0, text.length, text);
      newNumber = text;
      creditCardType = CreditCardFormModel.validateCCNum(_model.number);
      _model.flag = creditCardType.name;
    });
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormNumberEvent(number: _model.number));
  }

  void _handlerEventName(String text) {
    setState(() {
      _model.nameUser = text;
    });
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormNameEvent(name: _model.nameUser));
  }

  void _handlerEventDate(String text) {
    setState(() {
      _model.dateExpire = text;
    });
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormDateEvent(date: _model.dateExpire));
  }

  void _handlerEventCvv(String text) {
    setState(() {
      _model.cvv = text;
    });
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormCvvEvent(cvv: _model.cvv));
  }

  void _handlerEventButton() {
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormEnableButtonEvent(model: _model));
  }

  void _prev() {
    Util.closeKeyboard(context);
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormPrevEvent(model: _model));
  }

  void _next() {
    Util.closeKeyboard(context);
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormNextEvent(model: _model));
  }

  void _handlerResult(TransferObject result) {
    setState(() {
      _result = result;
    });
  }

  void _handlerResetData() {
    setState(() {
      _model = CreditCardFormModel.initObject();
      _model.step = 1;
      newNumber = maskNumber;
      creditCardType = CreditCardType.undefined;
      _handlerEventNumber(_model.number);
    });
  }

  void _handlerDataToEdit(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    if(arguments['edit']!=null && _model.rowId.isEmpty) {
      print("DADOS A EDITAR ---------------------- ${arguments['edit']}");
      setState(() {
        var modelEdit = arguments['edit'] as CreditCardModel;
        _model.rowId = modelEdit.rowId;
        _model.idUser = modelEdit.idUser;
        _model.status = modelEdit.status;
        _model.step = 1;
         _handlerEventCvv(modelEdit.cvv);
        _handlerEventDate(modelEdit.dateExpire);
        _handlerEventName(modelEdit.nameUser);
        _handlerEventNumber(modelEdit.number);
        _handlerEventButton();
      });
    }
  }

  Widget _frontCard() {
    return CreditCardItem(
      isFront: true,
      status: '',
      typeCard: creditCardType,
      nameUser: _model.nameUser.isEmpty ? "SEU NOME": _model.nameUser,
      numberCard: newNumber,
      dateExpiredCard: _model.dateExpire.isEmpty ? "00/0000" : _model.dateExpire,
      cvvCard: "",
      isExpanded: true,
    );
  }

  Widget _backCard() {
    return CreditCardItem(
      isFront: false,
      status: '',
      typeCard: creditCardType,
      nameUser: "",
      numberCard: "",
      dateExpiredCard: "",
      cvvCard: _model.cvv,
      isExpanded: true,
    );
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    _handlerDataToEdit(context);
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop) async {
        if (didPop) {
          return;
        }
        Navigator.of(context).pop(_result);
      },
    child:Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("ByteBank"),
      ),
      body: CustomScrollView(
        slivers: [
        SliverFillRemaining(
        hasScrollBody: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
                  listenWhen: (context, state) {
                return (state is CreditCardFlipper) || (state is CreditCardFormStateInitial);
              }, listener: (context, state) {
                (state is CreditCardFlipper) ? cardKey.currentState?.toggleCard() : _handlerResetData();
              }, builder: (context, state) {
                print("FLIPPER---------------------- $state");
                return FlipCard(
                  key: cardKey,
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  side: CardSide.FRONT,
                  flipOnTouch: false,
                  front: _frontCard(),
                  back: _backCard(),
                );
              }),
              const Spacer(),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    inputNumber(model: _model, eventNumber: _handlerEventNumber, eventButton: _handlerEventButton,),
                    inputName(model: _model, eventName: _handlerEventName, eventButton: _handlerEventButton,),
                    inputDate(model: _model, eventDate: _handlerEventDate, eventButton: _handlerEventButton,),
                    inputCvv(model: _model, eventCvv: _handlerEventCvv, eventButton: _handlerEventButton,),
                    inputButtons(result: _handlerResult, prev: _prev, next: _next,),
                  ],
                ),
              ),
            ],
          ),
        ),
      )],
      ),
      ),
    );
  }
}
