part of 'my_profile_bloc.dart';

abstract class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

class SignOutEvent extends MyProfileEvent {
  const SignOutEvent();
}

class EditInfoEvent extends MyProfileEvent {
  const EditInfoEvent({required this.userUpdatePrams});
  final UserUpdatePrams userUpdatePrams;
}
