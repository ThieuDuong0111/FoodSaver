part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpSubmitEvent extends SignUpEvent {
  const SignUpSubmitEvent({
    required this.signUpRequest,
  });
  final SignUpRequest signUpRequest;
}
