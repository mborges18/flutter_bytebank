
import '../model/creditcard_model.dart';

abstract class CreditCardListState {}

class CreditCardListStateInitial extends CreditCardListState {}
class CreditCardListStateLoading extends CreditCardListState {}
class CreditCardListDeleteStateLoading extends CreditCardListState {
  final String number;
  CreditCardListDeleteStateLoading(this.number);
}
class CreditCardListEditStateLoading extends CreditCardListState {
  final String number;
  CreditCardListEditStateLoading(this.number);
}
class CreditCardListStateSuccess extends CreditCardListState {
  final List<CreditCardModel> list;
  CreditCardListStateSuccess(this.list);
}
class CreditCardListEditStateSuccess extends CreditCardListState {
  final CreditCardModel model;
  CreditCardListEditStateSuccess(this.model);
}
class CreditCardListStateError extends CreditCardListState {}