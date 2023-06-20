// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['id'] as String,
      name: json['name'] as String,
      password1: json['password1'] as String,
      password2: json['password2'] as String,
      email: json['email'] as String,

    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'password1': instance.password1,
      'password2': instance.password2,
      'email': instance.email,
    };
