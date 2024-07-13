part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchByNamePageEvent extends SearchEvent {
  const SearchByNamePageEvent(this.productName);
  final String productName;
}
