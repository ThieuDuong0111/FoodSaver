part of 'customer_support_bloc.dart';

abstract class CustomerSupportState extends Equatable {
  const CustomerSupportState();  

  @override
  List<Object> get props => [];
}
class CustomerSupportInitial extends CustomerSupportState {}
