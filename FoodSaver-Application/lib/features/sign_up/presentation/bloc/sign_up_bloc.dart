import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/entities/sign_up_request.dart';
import 'package:funix_thieudvfx_foodsaver/features/sign_up/domain/usecases/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._signUpUsecase) : super(SignUpInitial()) {
    on<SignUpSubmitEvent>(_onSignUpSubmit);
  }

  final SignUpUsecase _signUpUsecase;

  FutureOr<void> _onSignUpSubmit(
    SignUpSubmitEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpSubmitLoadingState());
    final Either<SignUpEntity, SignUpEntity> result = await _signUpUsecase(event.signUpRequest);
    result.fold(
      (left) => emit(SignUpSubmitErrorState(signUpEntity: left)),
      (right) => emit(SignUpSubmitFinishedState(signUpEntity: right)),
    );
  }
}
