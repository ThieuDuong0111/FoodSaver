import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';

class UserInfoNotifier extends ChangeNotifier {
  UserInfoNotifier();

  static final provider = ChangeNotifierProvider<UserInfoNotifier>((ref) {
    return UserInfoNotifier();
  });
  UserEntity _userEntity = UserEntity(id: 0, address: '', name: '', imageUrl: '', email: '', phone: '');
  UserEntity get userInfo => _userEntity;

  Future<void> setUserInfo(UserEntity userEntity) async {
    _userEntity = userEntity;
    notifyListeners();
  }
}
