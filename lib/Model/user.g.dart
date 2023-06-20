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
      admin: json['admin'] as String,
      image: json['image'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      apartment: json['apartment'] as String,
      unit: json['unit'] as String,
      apartmentId: json['apartmentId'] as String,

    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'password1': instance.password1,
      'password2': instance.password2,
      'email': instance.email,
      'admin': instance.admin,
      'image': instance.image,
      'country': instance.country,
      'city': instance.city,
      'apartment': instance.apartment,
      'unit': instance.unit,
      'apartmentId': instance.apartmentId,
    };
