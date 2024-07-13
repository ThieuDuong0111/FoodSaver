import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/usecases/sign_in_use_case.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._signInUsecase, this._appStorage) : super(SignInInitial()) {
    on<SignInSubmitEvent>(_onSignInSubmit);
    on<ContinueWithoutSignInEvent>(_onContinueWithoutSignIn);
  }

  final SignInUsecase _signInUsecase;
  final AppStorage _appStorage;

  FutureOr<void> _onSignInSubmit(
    SignInSubmitEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInSubmitLoadingState());
    final Either<SignInEntity, SignInEntity> result = await _signInUsecase(event.signInRequest);
    result.fold(
      (left) => emit(SignInSubmitErrorState(signInEntity: left)),
      (right) => emit(SignInSubmitFinishedState(signInEntity: right)),
    );
  }

  FutureOr<void> _onContinueWithoutSignIn(
    ContinueWithoutSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(ContinueWithoutSignInLoadingState());
    await _appStorage.deleteValue(key: 'token');
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      emit(const ContinueWithoutSignInFinishedState());
    } catch (e) {
      emit(const ContinueWithoutSignInErrorState());
    }
  }
}
