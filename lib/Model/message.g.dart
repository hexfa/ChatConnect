// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  json['senderUidDoc'] as String,
  json['getterUidDoc'] as String,
  json['senderDoc'] as String,
  json['getterDoc'] as String,
  sender:json['sender'] as String?,
  getter: json['getter'] as String,
  senderUid: json['senderUid'] as String,
  getterUid: json['getterUid'] as String,
  image: json['image'] as String,
  time: json['time'] as String,
  pm: json['pm'] as String,



);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'senderDoc': instance.senderDoc,
  'getterDoc': instance.getterDoc,
  'senderUidDoc': instance.senderUidDoc,
  'getterUidDoc': instance.getterUidDoc,
  'sender': instance.sender,
  'getter': instance.getter,
  'senderUid': instance.senderUid,
  'getterUid': instance.getterUid,
  'image': instance.image,
  'time': instance.time,
  'pm': instance.pm,



};
