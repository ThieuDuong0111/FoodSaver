import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/usecases/edit_info_usecase.dart';
import 'package:injectable/injectable.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

@injectable
class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc(this._appStorage, this._editInfoUsecase) : super(MyProfileInitial()) {
    on<SignOutEvent>(_signOut);
    on<EditInfoEvent>(_editInfo);
  }

  final AppStorage _appStorage;

  FutureOr<void> _signOut(
    SignOutEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(SignOutLoadingState());
    await _appStorage.deleteValue(key: 'token');
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      emit(const SignOutFinishedState());
    } catch (e) {
      emit(const SignOutErrorState());
    }
  }

  final EditInfoUsecase _editInfoUsecase;

  FutureOr<void> _editInfo(
    EditInfoEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(EditInfoLoadingState());
    final Either<Failure, UserEntity> result = await _editInfoUsecase(event.userUpdatePrams);
    result.fold(
      (left) => emit(EditInfoErrorState(failure: left)),
      (right) => emit(EditInfoFinishedState(userEntity: right)),
    );
  }
}
