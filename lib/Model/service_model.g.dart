// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceData _$ServiceDataFromJson(Map<String, dynamic> json) => ServiceData(
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      telephone: json['telephone'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      website: json['website'] as String,
      instagram: json['instagram'] as String,
      facebook: json['facebook'] as String,
      twitter: json['twitter'] as String,
      linkedin: json['linkedin'] as String,
    );

Map<String, dynamic> _$ServiceDataToJson(ServiceData instance) =>
    <String, dynamic>{
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'telephone': instance.telephone,
      'mobile': instance.mobile,
      'email': instance.email,
      'website': instance.website,
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'linkedin': instance.linkedin,
    };
