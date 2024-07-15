import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:funix_thieudvfx_foodsaver/core/constants/api_endpoints.dart';
import 'package:funix_thieudvfx_foodsaver/core/data/domain_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/core/exception/api_exception.dart';
import 'package:funix_thieudvfx_foodsaver/core/storage/app_storage.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/data/models/user_model.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/entities/user_entity.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/mapper/user_from_model_to_user_entity_mapper.dart';
import 'package:funix_thieudvfx_foodsaver/features/my_profile/domain/usecases/edit_info_usecase.dart';
// ignore: library_prefixes
import 'package:http/http.dart' as httpMultiPart;

abstract class EditInfoRemoteDataSource {
  Future<Either<Failure, UserEntity>> editInfo(UserUpdatePrams userUpdatePrams);
}

@LazySingleton(as: EditInfoRemoteDataSource)
class EditInfoRemoteDataSourceImpl implements EditInfoRemoteDataSource {
  EditInfoRemoteDataSourceImpl(
    // this._appLogger,
    this._userFromModelToEntityMapper,
    this._appStorage,
  );
  final AppStorage _appStorage;
  // final AppLogger _appLogger;
  final UserFromModelToEntityMapper _userFromModelToEntityMapper;

  @override
  Future<Either<Failure, UserEntity>> editInfo(UserUpdatePrams userUpdatePrams) async {
    try {
      final String? token = await _appStorage.readValue(key: 'token');
      if (token == null) {
        throw Exception();
      }
      final request = httpMultiPart.MultipartRequest('PUT', Uri.parse('${ApiEndpoints.baseUrl}/user/update-info'));
      request.headers.addAll(
        <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (userUpdatePrams.avatar != null) {
        final picture = httpMultiPart.MultipartFile.fromBytes(
          'imageFile',
          File(userUpdatePrams.avatar!.path).readAsBytesSync(),
          filename: userUpdatePrams.avatar!.path,
        );
        request.files.add(picture);
        // print("size: " + userUpdatePrams.avatar!.l)
        // request.files.add(
        //   httpMultiPart.MultipartFile.fromString('data', jsonEncode('')),
        // );
      }

      request.fields.addAll(
        <String, String>{
          'email': userUpdatePrams.userUpdateRequest.email!,
          'phone': userUpdatePrams.userUpdateRequest.phone!,
          'address': userUpdatePrams.userUpdateRequest.address!,
        },
      );
      final response = await request.send();

      final reponseBody = await response.stream.bytesToString();
      // _appLogger.info(
      //   '==> RESPONE:\n$reponseBody',
      // );

      if (response.statusCode == 200) {
        final UserModel model = UserModel.fromJson(json.decode(reponseBody));
        return Right(_userFromModelToEntityMapper.fromModel(model)!);
      }
      throw Exception();
      // final Response response = await _appHttpClient.put(
      //   Uri.parse(
      //     '${ApiEndpoints.baseUrl}/user/update-user',
      //   ),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   },
      // );

      // final UserModel model = UserModel.fromJson(json.decode(response.body));
      // if (response.statusCode == 200) {
      //   return Right(_userFromModelToEntityMapper.fromModel(model)!);
      // }
    } catch (error) {
      return Left(APIException.handle(error).failure);
    }
  }
}
