
import 'package:bloc/bloc.dart';
import '../../../../core/clienthttp/StatusRequest.dart';
import '../data/creditcard_list_repository.dart';
import '../model/creditcard_model.dart';
import 'creditcard_list_event.dart';
import 'creditcard_list_state.dart';

class CreditCardListBloc extends Bloc<CreditCardListEvent, CreditCardListState> {

  CreditCardListBloc(
    CreditCardListRepository repository,
  ) : super(CreditCardListStateInitial()) {

    on<HomeCreditCardsListEvent>((event, emit) async {
      emit(CreditCardListStateLoading());
      var response = await repository.getCreditCards();
      if (response is Success) {
        emit(CreditCardListStateSuccess(response.object as List<CreditCardModel>));
      }  else {
        emit(CreditCardListStateError());
      }
    });

    on<HomeCreditCardsDeleteEvent>((event, emit) async {
      String number = event.list.singleWhere((element) => element.rowId==event.id).number;
      emit(CreditCardListDeleteStateLoading(number));
      var response = await repository.deleteCreditCard(event.id);
      if (response is Success) {
        event.list.removeWhere((element) => element.rowId==event.id);
        //event.list.firstWhere((element) => element.rowId==event.id).status="DELETED";
        emit(CreditCardListStateSuccess(event.list));
      }  else {
        emit(CreditCardListStateError());
      }
    });

    on<HomeCreditCardsEditEvent>((event, emit) async {
      String number = event.list.singleWhere((element) => element.rowId==event.id).number;
      emit(CreditCardListEditStateLoading(number));
      var response = await repository.editCreditCard(event.id);
      if (response is Success) {
        //event.list.firstWhere((element) => element.rowId==event.id).status="EDITED";
        emit(CreditCardListEditStateSuccess(response.object as CreditCardModel));
      }  else {
        emit(CreditCardListStateError());
      }
    });
  }
}