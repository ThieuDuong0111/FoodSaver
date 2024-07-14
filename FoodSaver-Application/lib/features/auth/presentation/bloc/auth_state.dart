part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthInitAppLoadingState extends AuthState {}

class AuthInitAppErrorState extends AuthState {
  const AuthInitAppErrorState();
}

class AuthInitAppFinishedState extends AuthState {
  const AuthInitAppFinishedState({
    required this.userEntity,
    required this.cartItemsCount,
  });
  final UserEntity userEntity;
  final int cartItemsCount;
}
