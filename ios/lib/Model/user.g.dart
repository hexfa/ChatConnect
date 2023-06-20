// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['id'] as String,
      name: json['name'] as String,
      lastName: json['lastName'] as String? ?? '',
      password1: json['password1'] as String,
      password2: json['password2'] as String,
      number: json['number'] as String,
      email: json['email'] as String,
      city: json['city'] as String,
      day: json['day'] as String,
      month: json['month'] as String,
      year: json['year'] as String,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastName': instance.lastName,
      'password1': instance.password1,
      'password2': instance.password2,
      'number': instance.number,
      'email': instance.email,
      'city': instance.city,
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
    };
