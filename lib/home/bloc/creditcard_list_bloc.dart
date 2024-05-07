
import 'package:bloc/bloc.dart';
import '../../clienthttp/StatusRequest.dart';
import '../data/creditcard_list_repository.dart';
import '../model/creditcard_model.dart';
import 'creditcard_list_event.dart';
import 'creditcard_list_state.dart';

class CreditCardListBloc extends Bloc<CreditCardListEvent, CreditCardListState> {

  var repository = CreditCardListRepositoryImpl();

  CreditCardListBloc() :super(HomeStateInitial()) {
    on<HomeCreditCardsListEvent>((event, emit) async {
      emit(HomeListStateLoading());
      var response = await repository.getCreditCards();
      if (response is Success) {
        emit(HomeListStateSuccess(response.object as List<CreditCardModel>));
      }  else {
        emit(HomeStateError());
      }
    });

    on<HomeCreditCardsDeleteEvent>((event, emit) async {
      emit(HomeDeleteStateLoading());
      var response = await repository.deleteCreditCard(event.id);
      if (response is Success) {
        event.list.firstWhere((element) => element.rowId==event.id).status="DELETED";
        emit(HomeListStateSuccess(event.list));
      }  else {
        emit(HomeStateError());
      }
    });

    on<HomeCreditCardsEditEvent>((event, emit) async {
      emit(HomeEditStateLoading());
      var response = await repository.editCreditCard(event.id);
      if (response is Success) {
        emit(HomeEditStateSuccess(response.object as CreditCardModel));
      }  else {
        emit(HomeStateError());
      }
    });
  }
}