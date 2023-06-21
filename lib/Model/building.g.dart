// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingData _$buildingDataFromJson(Map<String, dynamic> json) => BuildingData(
      id:json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      address: json['address'] as String,
      adminName: json['admin'] as String,

    );

Map<String, dynamic> _$PetDataToJson(BuildingData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'country': instance.country,
      'address': instance.address,
      'admin': instance.adminName,

    };
