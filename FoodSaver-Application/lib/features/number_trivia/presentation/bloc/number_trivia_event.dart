part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class NumberTriviaConcreteEvent extends NumberTriviaEvent {
  const NumberTriviaConcreteEvent({
    required this.number,
  });
  final String number;
}

class NumberTriviaRandomEvent extends NumberTriviaEvent {}
