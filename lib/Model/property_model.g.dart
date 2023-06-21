// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyData _$PropertyDataFromJson(Map<String, dynamic> json) => PropertyData(
  sender:json['sender'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  time: json['time'] as String,
  image: json['image'] as List,
  price: json['price'] as String,
  sale: json['sale'] as String,
  rent: json['rent'] as String,
  senderName: json['senderName'] as String?,

);

Map<String, dynamic> _$PropertyDataToJson(PropertyData instance) => <String, dynamic>{
  'sender': instance.sender,
  'title': instance.title,
  'description': instance.description,
  'time': instance.time,
  'image': instance.image,
  'price': instance.price,
  'sale': instance.sale,
  'rent': instance.rent,
  'senderName': instance.senderName,


};
