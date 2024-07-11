part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpSubmitLoadingState extends SignUpState {}

class SignUpSubmitErrorState extends SignUpState {
  const SignUpSubmitErrorState({required this.signUpEntity});
  final SignUpEntity signUpEntity;
}

class SignUpSubmitFinishedState extends SignUpState {
  const SignUpSubmitFinishedState({
    required this.signUpEntity,
  });
  final SignUpEntity signUpEntity;
}
