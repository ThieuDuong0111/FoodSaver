import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/usecase/usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/entities/cart_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/cart/domain/usecases/cart_get_items_usecase.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/usecases/user_info_usecase.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._userInfoUsecase, this._cartGetItemsUsecase) : super(AuthInitial()) {
    on<AuthInitAppEvent>(_authInitApp);
  }

  final UserInfoUsecase _userInfoUsecase;
  final CartGetItemsUsecase _cartGetItemsUsecase;

  FutureOr<void> _authInitApp(
    AuthInitAppEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInitAppLoadingState());
    final Either<Failure, UserEntity> result = await _userInfoUsecase(NoParams());
    final Either<Failure, CartEntity> cart = await _cartGetItemsUsecase(NoParams());
    UserEntity userEntity = UserEntity(
      id: 0,
      address: '',
      name: '',
      imageUrl: '',
      email: '',
      phone: '',
      storeName: '',
      storeImageUrl: '',
      storeDescription: '',
    );

    result.fold(
      (left) => emit(const AuthInitAppErrorState()),
      (right) {
        userEntity = right;
      },
    );

    cart.fold(
      (left) => emit(const AuthInitAppErrorState()),
      (right) => emit(AuthInitAppFinishedState(userEntity: userEntity, cartItemsCount: right.itemsCount)),
    );
  }
}
