import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/entities/sign_in_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_in/domain/usecases/sign_in_use_case.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._signInUsecase) : super(SignInInitial()) {
    on<SignInSubmitEvent>(_onSignInSubmit);
  }

  final SignInUsecase _signInUsecase;

  FutureOr<void> _onSignInSubmit(
    SignInSubmitEvent event,
    Emitter<SignInState> emit,
  ) async {
    final Either<SignInEntity, SignInEntity> result = await _signInUsecase(event.signInRequest);
    emit(SignInSubmitLoadingState());
    result.fold(
      (left) => emit(SignInSubmitErrorState(signInEntity: left)),
      (right) => emit(SignInSubmitFinishedState(signInEntity: right)),
    );
  }
}
