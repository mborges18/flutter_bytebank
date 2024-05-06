
import 'package:bloc/bloc.dart';
import '../../clienthttp/StatusRequest.dart';
import '../data/home_repository.dart';
import '../model/creditcard_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  var repository = HomeRepositoryImpl();

  HomeBloc() :super(HomeStateInitial()) {
    on<HomeListCreditCardsEvent>((event, emit) async {
      emit(HomeStateLoading());
      var response = await repository.getCreditCards();
      if (response is Success) {
        emit(HomeStateSuccess(response.object as List<CreditCardModel>));
      }  else {
        emit(HomeStateError());
      }
    });
  }
}