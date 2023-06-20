// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VetData _$VetDataFromJson(Map<String, dynamic> json) => VetData(
      json['id'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      number: json['number'] as String,
      city: json['city'] as String,
      cityShop: json['cityShop'] as String,
      profession: json['profession'] as String,
      expertise: json['expertise'] as String,
      jobTitle: json['jobTitle'] as String,
      shopName: json['shopName'] as String,
      image: json['image'] as String? ?? '',
      nit: json['nit'] as String,
      direction: json['direction'] as String,
      servicesRendered: json['servicesRendered'] as String,
    );

Map<String, dynamic> _$VetDataToJson(VetData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
      'number': instance.number,
      'city': instance.city,
      'cityShop': instance.cityShop,
      'profession': instance.profession,
      'expertise': instance.expertise,
      'jobTitle': instance.jobTitle,
      'shopName': instance.shopName,
      'nit': instance.nit,
      'direction': instance.direction,
      'servicesRendered': instance.servicesRendered,
      'image': instance.image,
    };
