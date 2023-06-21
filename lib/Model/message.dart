import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String? sender='';
  String getter = '';
  String senderUid = '';
  String getterUid = '';
  String senderUidDoc = '';
  String getterUidDoc = '';
  String? senderDoc='';
  String getterDoc = '';
  String time = '';
  String image = '';
  String pm = '';


  Message(this.getterUidDoc,this.senderUidDoc,this.senderDoc,this.getterDoc,{
    required this.sender,
    required this.getter,
    required this.senderUid,
    required this.getterUid,
    required this.image,
    required this.time,
    required this.pm,

  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
