import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/store/domain/usecases/list_stores_usecase.dart';
import 'package:injectable/injectable.dart';

part 'store_event.dart';
part 'store_state.dart';

@injectable
class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc(this._listStoresUsecase) : super(StoreInitial()) {
    on<StoresPageEvent>(_listStoresPage);
  }

  final ListStoresUsecase _listStoresUsecase;
  FutureOr<void> _listStoresPage(
    StoresPageEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(StoresPageLoadingState());
    final Either<Failure, List<UserEntity>> result = await _listStoresUsecase(NoParams());
    result.fold(
      (left) => emit(StoresPageErrorState(failure: left)),
      (right) => emit(StoresPageFinishedState(listStores: right)),
    );
  }
}
