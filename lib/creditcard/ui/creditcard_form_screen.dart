import 'package:flutter/cupertino.dart';
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
import '../model/creditcard_model.dart';

class CreditCardFormScreen extends StatefulWidget {
  const CreditCardFormScreen({super.key});

  @override
  State<CreditCardFormScreen> createState() => _CreditCardFormScreenState();
}

class _CreditCardFormScreenState extends State<CreditCardFormScreen> {
  final CreditCardModel _model =
      CreditCardModel(name: "", number: "", date: "", cvv: "");

  String? _handleErrorNumber(CreditCardFormState state) {
    return (state is CreditCardFromStateNumber) ? state.message : null;
  }

  void _handlerEventNumber(String text) {
    setState(() {
      _model.number = text;
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

  void _register(CreditCardFormState state) {
    Util.closeKeyboard(context);
    BlocProvider.of<CreditCardFormBloc>(context)
        .add(CreditCardFormSubmitEvent(model: _model));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("ByteBank"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
             Container(
              color: Colors.white,
              child: const CreditCardItem(
                typeCard: CreditCardType.undefined,
                nameUser: "SEU NOME",
                numberCard: "XXXX XXXX XXXX XXXX",
                dateExpiredCard: "00/0000",
                expanded: true,
              ),
            ),
            const Spacer(flex: 1,),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Visibility(
                    visible: false,
                    child:
                        BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
                            listenWhen: (context, state) {
                              return (state is CreditCardFromStateNumber);
                            },
                            listener: (context, state) {},
                            buildWhen: (context, state) {
                              return (state is CreditCardFromStateNumber);
                            },
                            builder: (context, state) {
                              return InputText(
                                textLabel: labelNumberCC,
                                textHint: hintNumberCC,
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
                              );
                            }),
                  ),
                  Visibility(
                    visible: false,
                    child:
                        BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
                            listenWhen: (context, state) {
                              return (state is CreditCardFromStateName);
                            },
                            listener: (context, state) {},
                            buildWhen: (context, state) {
                              return (state is CreditCardFromStateName);
                            },
                            builder: (context, state) {
                              return InputText(
                                textLabel: labelNameLikeCC,
                                textHint: hintName.toUpperCase(),
                                inputType: TextInputType.name,
                                iconStart: Icons.person_2_outlined,
                                onValidatorListener: () {
                                  return _handleErrorName(state);
                                },
                                onTextChangeListener: (text) {
                                  _handlerEventName(text ?? "");
                                  _handlerEventButton(state);
                                },
                              );
                            }),
                  ),
                  Visibility(
                    visible: false,
                    child:
                        BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
                            listenWhen: (context, state) {
                              return (state is CreditCardFromStateDate);
                            },
                            listener: (context, state) {},
                            buildWhen: (context, state) {
                              return (state is CreditCardFromStateDate);
                            },
                            builder: (context, state) {
                              return InputText(
                                textLabel: labelExpiredDate,
                                textHint: hintDate,
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
                              );
                            }),
                  ),
                  Visibility(
                    visible: true,
                    child:
                        BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
                            listenWhen: (context, state) {
                              return (state is CreditCardFromStateCvv);
                            },
                            listener: (context, state) {},
                            buildWhen: (context, state) {
                              return (state is CreditCardFromStateCvv);
                            },
                            builder: (context, state) {
                              return InputText(
                                textLabel: labelCvvCC,
                                textHint: hintCvvCC,
                                inputType: TextInputType.number,
                                iconStart: Icons.security,
                                onValidatorListener: () {
                                  return _handleErrorCvv(state);
                                },
                                onTextChangeListener: (text) {
                                  _handlerEventCvv(text ?? "");
                                  _handlerEventButton(state);
                                },
                              );
                            }),
                  ),
                  BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
                      listenWhen: (context, state) {
                    return (state is CreditCardFormStateSuccess) ||
                        (state is CreditCardFormStateError);
                  }, listener: (context, state) {
                    if ((state is CreditCardFormStateSuccess)) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const AuthenticatorScreen()),
                      // );
                    } else {
                      const AlertInformation(
                              title: titleInformation,
                              description: msgErrorUnKnow)
                          .showError(context);
                    }
                  }, builder: (context, state) {
                    return ButtonFilled(
                        textButton: actionNext.toUpperCase(),
                        isEnabled: (state is CreditCardFromStateButton)
                            ? state.isEnabled
                            : false,
                        isLoading: (state is CreditCardFormStateLoading) == true
                            ? true
                            : false,
                        functionClick: () {
                          _register(state);
                        });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
