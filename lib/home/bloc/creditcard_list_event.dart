
import '../model/creditcard_model.dart';

abstract class CreditCardListEvent {}

class HomeCreditCardsListEvent extends CreditCardListEvent {}
class HomeCreditCardsDeleteEvent extends CreditCardListEvent {
  final String id;
  final List<CreditCardModel> list;
  HomeCreditCardsDeleteEvent({required this.id, required this.list});
}
class HomeCreditCardsEditEvent extends CreditCardListEvent {
  final String id;
  HomeCreditCardsEditEvent({required this.id});
}