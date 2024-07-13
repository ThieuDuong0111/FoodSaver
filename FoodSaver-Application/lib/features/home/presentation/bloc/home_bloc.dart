import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/entities/home_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/domain/usecases/home_use_case.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._homeUsecase) : super(HomeInitial()) {
    on<HomePageEvent>(_homePage);
  }
  final HomeUsecase _homeUsecase;
  FutureOr<void> _homePage(
    HomePageEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomePageLoadingState());
    final Either<Failure, HomeEntity> result = await _homeUsecase(NoParams());
    result.fold(
      (left) => emit(HomePageErrorState(failure: left)),
      (right) => emit(HomePageFinishedState(homeEntity: right)),
    );
  }
}
