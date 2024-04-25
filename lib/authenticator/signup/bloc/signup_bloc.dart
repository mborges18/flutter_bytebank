import 'package:bloc/bloc.dart';
import '../data/SignUpRepository.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final repository = SignUpRepository();

  SignUpBloc() : super(SignUpStateInitial()) {
    on<SignUpEnableButtonEvent>((event, emit) async {

    });

    on<SignUpSetNameEvent>((event, emit) async {

    });

    on<SignUpSetBirthDateEvent>((event, emit) async {

    });

    on<SignUpSetPhoneEvent>((event, emit) async {

    });

    on<SignUpSetEmailEvent>((event, emit) async {

    });

    on<SignUpSetPasswordEvent>((event, emit) async {

    });

    on<SignUpSetPasswordConfirmEvent>((event, emit) async {

    });
  }
}