part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSubmitLoadingState extends SignInState {}

class SignInSubmitErrorState extends SignInState {
  const SignInSubmitErrorState({required this.signInEntity});
  final SignInEntity signInEntity;
}

class SignInSubmitFinishedState extends SignInState {
  const SignInSubmitFinishedState({
    required this.signInEntity,
  });
  final SignInEntity signInEntity;
}
