import 'package:json_annotation/json_annotation.dart';

part 'property_model.g.dart';

@JsonSerializable()
class PropertyData {
  String sender='';
  String title = '';
  String description = '';
  String time = '';
  List image = [];
  String price = '';
  String sale = '';
  String rent = '';
  String? senderName='';

  PropertyData({
    required this.sender,
    required this.title,
    required this.description,
    required this.time,
    required this.image,
    required this.price,
    required this.sale,
    required this.rent,
    required this.senderName,


  });

  factory PropertyData.fromJson(Map<String, dynamic> json) => _$PropertyDataFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDataToJson(this);
}
