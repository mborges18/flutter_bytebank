
import '../model/creditcard_model.dart';

abstract class CreditCardListState {}

class CreditCardListStateInitial extends CreditCardListState {}
class CreditCardListStateLoading extends CreditCardListState {}
class CreditCardListDeleteStateLoading extends CreditCardListState {}
class CreditCardListEditStateLoading extends CreditCardListState {}
class CreditCardListStateSuccess extends CreditCardListState {
  final List<CreditCardModel> list;
  CreditCardListStateSuccess(this.list);
}
class CreditCardListEditStateSuccess extends CreditCardListState {
  final CreditCardModel model;
  CreditCardListEditStateSuccess(this.model);
}
class CreditCardListStateError extends CreditCardListState {}