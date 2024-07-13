import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:injectable/injectable.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

@injectable
class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc(this._appStorage) : super(MyProfileInitial()) {
    on<SignOutEvent>(_signOut);
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
}
