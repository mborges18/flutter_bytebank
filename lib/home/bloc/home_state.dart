
import '../model/creditcard_model.dart';

abstract class HomeState {}

class HomeStateInitial extends HomeState {}
class HomeStateLoading extends HomeState {}
class HomeStateSuccess extends HomeState {
  final List<CreditCardModel> list;
  HomeStateSuccess(this.list);
}
class HomeStateError extends HomeState {}