import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/entities/number_trivia_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/usecases/get_concrete_number_trivia_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/number_trivia/domain/usecases/get_random_number_trivia_usecase.dart';
import 'package:injectable/injectable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

@injectable
class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  NumberTriviaBloc(
    this._getConcreteNumberTriviaUsecase,
    this._getRandomNumberTriviaUsecase,
  ) : super(NumberTriviaInitial()) {
    on<NumberTriviaConcreteEvent>(_onGetConcreteNumberTrivia);
    on<NumberTriviaRandomEvent>(_onGetRandomNumberTrivia);
  }

  final GetConcreteNumberTriviaUsecase _getConcreteNumberTriviaUsecase;
  final GetRandomNumberTriviaUsecase _getRandomNumberTriviaUsecase;

  FutureOr<void> _onGetConcreteNumberTrivia(
    NumberTriviaConcreteEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoadingState());

    try {
      emit(
        NumberTriviaFinishedState(
          numberTriviaEntity: await _getConcreteNumberTriviaUsecase(ConcreteNumberTriviaParams(event.number)),
        ),
      );
    } catch (error) {
      emit(NumberTriviaErrorState(error: error.toString()));
    }
  }

  FutureOr<void> _onGetRandomNumberTrivia(
    NumberTriviaRandomEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoadingState());
    // const String mioStorageKey = 'MIO_STORAGE_KEY';
    // const String mioStorageValue = '6789miovodoi';
    // //write value
    // await _appStorage.writeValue(key: mioStorageKey, value: mioStorageValue);
    // //read value
    // await _appStorage.readValue(key: mioStorageKey);

    // //delete value
    // await _appStorage.deleteValue(key: mioStorageKey);
    try {
      emit(
        NumberTriviaFinishedState(
          numberTriviaEntity: await _getRandomNumberTriviaUsecase(NoParams()),
        ),
      );
    } catch (error) {
      emit(NumberTriviaErrorState(error: error.toString()));
    }
  }
}
