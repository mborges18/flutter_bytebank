import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/components/inputs/MaskType.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/buttons/button_filled.dart';
import '../../components/dialogs/dialog_information.dart';
import '../../components/inputs/input_text.dart';
import '../../home/model/credit_card_type.dart';
import '../../home/ui/credit_card_view.dart';
import '../../util/string/strings.dart';
import '../../util/util.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_event.dart';
import '../bloc/creditcard_form_state.dart';
import '../model/creditcard_form_model.dart';

class CreditCardFormScreen extends StatefulWidget {
  const CreditCardFormScreen({super.key});

  @override
  State<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  CreditCardFormModel _model = CreditCardFormModel(name: "", number: "", date: "", cvv: "", flag: "");
  String maskNumber = "XXXX XXXX XXXX XXXX";
  String newNumber = "XXXX XXXX XXXX XXXX";
  CreditCardType creditCardType = CreditCardType.undefined;

  String? _handleErrorNumber(CreditCardFormState state) {
    return (state is CreditCardFromStateNumber) ? state.message : null;
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

  String? _handleErrorName(CreditCardFormState state) {
    return (state is CreditCardFromStateName) ? state.message : null;
  }

  void _handlerEventName(String text) {
    setState(() {
      _model.name = text;
    });
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormNameEvent(name: _model.name));
  }

  String? _handleErrorDate(CreditCardFormState state) {
    return (state is CreditCardFromStateDate) ? state.message : null;
  }

  void _handlerEventDate(String text) {
    setState(() {
      _model.date = text;
    });
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormDateEvent(date: _model.date));
  }

  String? _handleErrorCvv(CreditCardFormState state) {
    return (state is CreditCardFromStateCvv) ? state.message : null;
  }

  void _handlerEventCvv(String text) {
    setState(() {
      _model.cvv = text;
    });
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormCvvEvent(cvv: _model.cvv));
  }

  void _handlerEventButton(CreditCardFormState state) {
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormEnableButtonEvent(model: _model));
  }

  void _prev(CreditCardFormState state) {
    Util.closeKeyboard(context);
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormPrevEvent(model: _model));
  }

  void _next(CreditCardFormState state) {
    Util.closeKeyboard(context);
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormNextEvent(model: _model));
  }

  void _handlerResetData() {
    setState(() {
      _model = CreditCardFormModel(name: "", number: "", date: "", cvv: "", flag: "");
      _model.step = 1;
      newNumber = maskNumber;
      creditCardType = CreditCardType.undefined;
    });
  }

  Widget _frontCard() {
    return CreditCardItem(
      isFront: true,
      status: '',
      typeCard: creditCardType,
      nameUser: _model.name.isEmpty ? "SEU NOME": _model.name,
      numberCard: newNumber,
      dateExpiredCard: _model.date.isEmpty ? "00/0000" : _model.date,
      cvvCard: "",
      expanded: true,
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
      expanded: true,
    );
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Center(child:  Text("ByteBank")),
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
                    _inputNumber(),
                    _inputName(),
                    _inputDate(),
                    _inputCvv(),
                    _inputButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      )],
      ),
    );
  }

  Widget _inputNumber() {
    return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
        listener: (context, state) {},
        buildWhen: (context, state) {
          return (state is CreditCardFromStateNumber) || (state is CreditCardFromStateStep);
        },
        builder: (context, state) {
          print("STEP 1----------------------$state ${_model.number}");
          return Visibility(
            visible: (state is CreditCardFormStateInitial) ? true
                : (state is CreditCardFromStateNumber) ? true
                : (state is CreditCardFromStateStep) ? state.step==1 : false,
            child: InputText(
              textLabel: labelNumberCC,
              textHint: hintNumberCC,
              value: _model.number,
              inputType: TextInputType.number,
              maskType: MaskType.creditCard,
              iconStart: Icons.credit_card_rounded,
              onValidatorListener: () {
                return _handleErrorNumber(state);
              },
              onTextChangeListener: (text) {
                _handlerEventNumber(text ?? "");
                _handlerEventButton(state);
              },
            ),
          );
        });
  }

  Widget _inputName() {
    return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
        listener: (context, state) {},
        buildWhen: (context, state) {
          return (state is CreditCardFromStateName) || (state is CreditCardFromStateStep);
        },
        builder: (context, state) {
          print("STEP 2----------------------$state ${_model.name}");
          return Visibility(
            visible: (state is CreditCardFromStateName) ? true
                : (state is CreditCardFromStateStep) ? state.step==2 : false,
            child: InputText(
              textLabel: labelNameLikeCC,
              textHint: hintName,
              value: _model.name,
              inputType: TextInputType.name,
              iconStart: Icons.person_2_outlined,
              onValidatorListener: () {
                return _handleErrorName(state);
              },
              onTextChangeListener: (text) {
                _handlerEventName(text.toString().toUpperCase());
                _handlerEventButton(state);
              },
            ),
          );
        });
  }

  Widget _inputDate() {
    return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
        listener: (context, state) {},
        buildWhen: (context, state) {
          return (state is CreditCardFromStateDate) || (state is CreditCardFromStateStep);
        },
        builder: (context, state) {
          print("STEP 3----------------------$state ${_model.date}");
          return Visibility(
            visible: (state is CreditCardFromStateDate) ? true
                : (state is CreditCardFromStateStep) ? state.step==3 : false,
            child: InputText(
              textLabel: labelExpiredDate,
              textHint: hintDate,
              value: _model.date,
              maskType: MaskType.dateCreditCard,
              inputType: TextInputType.number,
              iconStart: Icons.calendar_month_outlined,
              onValidatorListener: () {
                return _handleErrorDate(state);
              },
              onTextChangeListener: (text) {
                _handlerEventDate(text ?? "");
                _handlerEventButton(state);
              },
            ),
          );
        });
  }

  Widget _inputCvv() {
    return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
        listenWhen: (context, state) {
          return (state is CreditCardFromStateCvv);
        },
        listener: (context, state) {
          // setState(() {
          //   _showFrontSide = false;
          // });
        },
        buildWhen: (context, state) {
          return (state is CreditCardFromStateCvv) || (state is CreditCardFromStateStep);
        },
        builder: (context, state) {
          print("STEP 4----------------------$state ${_model.cvv}");
          return Visibility(
            visible: (state is CreditCardFromStateStep) ? state.step==4 : false,
            child: InputText(
              textLabel: labelCvvCC,
              textHint: hintCvvCC,
              value: _model.cvv,
              inputType: TextInputType.number,
              maxLength: 4,
              iconStart: Icons.security,
              onValidatorListener: () {
                return _handleErrorCvv(state);
              },
              onTextChangeListener: (text) {
                _handlerEventCvv(text ?? "");
                _handlerEventButton(state);
              },
            ),
          );
        });
  }

  String _handlerNameButtonNext(CreditCardFormState state){
    if(state is CreditCardFromStateButton) {
      print("Name button next -> ${state.textAction}");
      return state.textAction;
    }
    print("Name button next -> $actionNext");
    return actionNext;
  }

  Widget _inputButtons() {
    return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
        listenWhen: (context, state) {
          return (state is CreditCardFormStateSuccess) || (state is CreditCardFormStateError);
        },
        listener: (context, state) {
          if ((state is CreditCardFormStateSuccess)) {
            const AlertInformation(
            title: titleInformation,
            description: msgErrorUnKnow).showSuccess(context);
      } else {
        const AlertInformation(
            title: titleInformation,
            description: msgErrorUnKnow).showError(context);
      }
    }, builder: (context, state) {
      return Row(
        children: [
          Expanded(
            flex: 5,
            child: ButtonFilled(
                textButton: actionPrev.toUpperCase(),
                isEnabled: (state is CreditCardFromStateButton)
                    ? state.isEnabledPrev
                    : false,
                isLoading: false,
                functionClick: () {
                  _prev(state);
                }),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: ButtonFilled(
                textButton: _handlerNameButtonNext(state).toUpperCase(),
                isEnabled: (state is CreditCardFromStateButton)
                    ? state.isEnabledNext
                    : false,
                isLoading:
                (state is CreditCardFormStateLoading) == true
                    ? true
                    : false,
                functionClick: () {
                  _next(state);
                }),
          ),
        ],
      );
    });
  }
}
