
import '../model/creditcard_model.dart';

abstract class CreditCardListState {}

class HomeStateInitial extends CreditCardListState {}
class HomeListStateLoading extends CreditCardListState {}
class HomeDeleteStateLoading extends CreditCardListState {}
class HomeEditStateLoading extends CreditCardListState {}
class HomeListStateSuccess extends CreditCardListState {
  final List<CreditCardModel> list;
  HomeListStateSuccess(this.list);
}
class HomeEditStateSuccess extends CreditCardListState {
  final CreditCardModel model;
  HomeEditStateSuccess(this.model);
}
class HomeStateError extends CreditCardListState {}