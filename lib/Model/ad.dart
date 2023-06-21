import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable()
class adData {
  String category='';
  String title = '';
  String description = '';
  String time = '';
  List image = [];
  String price = '';
  String sender = '';
  String? senderName='';


  adData({
    required this.category,
    required this.title,
    required this.description,
    required this.time,
    required this.image,
    required this.price,
    required this.sender,
    required this.senderName,

  });

  factory adData.fromJson(Map<String, dynamic> json) => _$adDataFromJson(json);

  Map<String, dynamic> toJson() => _$adDataToJson(this);
}
