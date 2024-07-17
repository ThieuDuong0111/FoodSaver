import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_support_event.dart';
part 'customer_support_state.dart';

class CustomerSupportBloc extends Bloc<CustomerSupportEvent, CustomerSupportState> {
  CustomerSupportBloc() : super(CustomerSupportInitial()) {
    on<CustomerSupportEvent>((event, emit) {});
  }
}
