part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInSubmitEvent extends SignInEvent {
  const SignInSubmitEvent({
    required this.signInRequest,
  });
  final SignInRequest signInRequest;
}

class ContinueWithoutSignInEvent extends SignInEvent {
  const ContinueWithoutSignInEvent();
}
