import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/usecases/user_info_usecase.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._userInfoUsecase) : super(AuthInitial()) {
    on<AuthInitAppEvent>(_authInitApp);
  }

  final UserInfoUsecase _userInfoUsecase;

  FutureOr<void> _authInitApp(
    AuthInitAppEvent event,
    Emitter<AuthState> emit,
  ) async {
    final Either<Failure, UserEntity> result = await _userInfoUsecase(NoParams());
    emit(AuthInitAppLoadingState());

    result.fold(
      (left) => emit(const AuthInitAppErrorState()),
      (right) => emit(AuthInitAppFinishedState(userEntity: right)),
    );
    return null;
  }
}
