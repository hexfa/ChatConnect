// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

adData _$adDataFromJson(Map<String, dynamic> json) => adData(
  category:json['category'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  time: json['time'] as String,
  image: json['image'] as List,
  price: json['price'] as String,
  sender: json['sender'] as String,
  senderName: json['senderName'] as String?,


);

Map<String, dynamic> _$adDataToJson(adData instance) => <String, dynamic>{
  'category': instance.category,
  'title': instance.title,
  'description': instance.description,
  'time': instance.time,
  'image': instance.image,
  'price': instance.price,
  'sender': instance.sender,
  'senderName':instance.senderName,


};
