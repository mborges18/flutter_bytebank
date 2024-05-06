
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter_bitybank/creditcard/bloc/creditcard_form_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../clienthttp/StatusRequest.dart';
import '../../home/model/credit_card_type.dart';
import '../../util/string/strings.dart';
import '../data/creditcard_form_repository.dart';
import '../model/creditcard_form_model.dart';
import 'creditcard_form_event.dart';

class CreditCardFormBloc extends Bloc<CreditCardFormEvent, CreditCardFormState> {

  var repository = CreditCardFormRepository();

  CreditCardFormBloc() : super(CreditCardFormStateInitial()){

    on<CreditCardFormNumberEvent>((event, emit) {
      var type = CreditCardFormModel.validateCCNum(event.number);
      if(event.number.length>=15  && type==CreditCardType.undefined){
        emit(CreditCardFromStateNumber(msgNumberInvalid));
      }else {
        emit(CreditCardFromStateNumber(null));
        emit(CreditCardFromStateStep(1));
      }
    });

    on<CreditCardFormNameEvent>((event, emit) {
      emit(CreditCardFromStateName(null));
      emit(CreditCardFromStateStep(2));
    });

    on<CreditCardFormDateEvent>((event, emit) {
      int month = int.parse(event.date.split("/")[0]);
      int year = int.parse(event.date.split("/")[1]);
      emit(CreditCardFromStateDate(null));
      if(event.date.length==7) {
        if (month > 12 || month == 00) {
          emit(CreditCardFromStateDate(msgMonthInvalid));
        } else if (year < DateTime.now().year || (year == DateTime.now().year && month < DateTime.now().month)) {
          emit(CreditCardFromStateDate(msgDateExpired));
        } else {
          emit(CreditCardFromStateDate(null));
          emit(CreditCardFromStateStep(3));
        }
      }
    });

    on<CreditCardFormCvvEvent>((event, emit) {
      emit(CreditCardFromStateCvv(null));
      emit(CreditCardFromStateStep(4));
    });

    on<CreditCardFormEnableButtonEvent>((event, emit) {
      _handlerEnableButton(event.model, emit);
    });

    on<CreditCardFormPrevEvent>((event, emit) {

      if(event.model.step==4) {
        event.model.step = 3;
        emit(CreditCardFromStateStep(3));
        emit(CreditCardFlipper());
      } else if(event.model.step==3) {
        event.model.step = 2;
        emit(CreditCardFromStateStep(2));
      } else if(event.model.step==2) {
        event.model.step = 1;
        emit(CreditCardFromStateStep(1));
      }
      print("CreditCardFormNextEvent------------ $event - step = ${event.model.step}");
      _handlerEnableButton(event.model, emit);
    });

    on<CreditCardFormNextEvent>((event, emit) async {

      if(event.model.step==1) {
        event.model.step = 2;
        emit(CreditCardFromStateStep(2));
      } else if(event.model.step==2) {
        event.model.step = 3;
        emit(CreditCardFromStateStep(3));
      } else if(event.model.step==3) {
        event.model.step = 4;
        emit(CreditCardFromStateStep(4));
        emit(CreditCardFlipper());
      } else if(event.model.step==4) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        event.model.idUser = jsonDecode(prefs.getString(userID) ?? "");
        emit(CreditCardFormStateLoading());
        var response = await repository.register(event.model);
        if (response is Success) {
          emit(CreditCardFormStateSuccess());
        } else if(response is Exists) {
          emit(CreditCardFormStateExists());
        } else {
          emit(CreditCardFormStateError());
        }
      }
      print("CreditCardFormNextEvent------------- $event - step = ${event.model.step}");
      _handlerEnableButton(event.model, emit);
    });

  }

  void _handlerEnableButton(CreditCardFormModel model, Emitter<CreditCardFormState> emit) {
    var isEnabledBtNext = false;
    var isEnabledBtPrev = false;

      if (model.step == 1) {
        isEnabledBtNext = model.number.length == 19;
      } else if (model.step == 2) {
        isEnabledBtPrev = true;
        isEnabledBtNext =  model.name.split(" ").length > 1 && model.name.split(" ")[1].length > 1;
      } else if (model.step == 3) {
        isEnabledBtPrev = true;
        isEnabledBtNext = model.date.length == 7;
      } else if (model.step == 4) {
        isEnabledBtPrev = true;
        isEnabledBtNext = model.cvv.length == 3 || model.cvv.length == 4;
      }
      print("CreditCardFormEnableButtonEvent-------------isEnabledPrev: $isEnabledBtPrev, isEnabledNext: $isEnabledBtNext");
      emit(CreditCardFromStateButton(
          isEnabledPrev: isEnabledBtPrev,
          isEnabledNext: isEnabledBtNext,
          textAction: model.step == 4 ? actionRegister : actionNext
      ));
  }
}