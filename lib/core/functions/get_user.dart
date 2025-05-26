// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import '../../modules/auth/data/models/user_model.dart';
import '../../modules/auth/domain/entities/user_entity.dart';
import '../database/cache_helper.dart';
import '../service/service_locator.dart';

UserEntity getUser() {
  var jsonString = getIt<CacheHelper>().getData(key: 'userData');
  var user;
  if (jsonString == null) {
    return UserEntity(
      name: '',
      email: '',
      uId: '',
    );
  } else {
    user = UserModel.fromJson(jsonDecode(jsonString));
  }

  if (user == null) {
    return UserEntity(
      name: '',
      email: '',
      uId: '',
    );
  } else {
    return user;
  }
}
