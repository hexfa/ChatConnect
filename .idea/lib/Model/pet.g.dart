// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetData _$PetDataFromJson(Map<String, dynamic> json) => PetData(
      json['id'] as String,
      name: json['name'] as String,
      breed: json['breed'] as String,
      petType: json['petType'] as String,
      sex: json['sex'] as String,
      day: json['day'] as String,
      month: json['month'] as String,
      year: json['year'] as String,
      image: json['image'] as String? ?? '',
      size: json['size'] as String? ?? '',
    );

Map<String, dynamic> _$PetDataToJson(PetData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'breed': instance.breed,
      'petType': instance.petType,
      'sex': instance.sex,
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'image': instance.image,
      'size': instance.size,
    };
