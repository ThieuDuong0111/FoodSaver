part of 'my_profile_bloc.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object> get props => [];
}

class MyProfileInitial extends MyProfileState {}

class SignOutLoadingState extends MyProfileState {}

class SignOutErrorState extends MyProfileState {
  const SignOutErrorState();
}

class SignOutFinishedState extends MyProfileState {
  const SignOutFinishedState();
}
