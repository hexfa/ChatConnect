import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart';

@JsonSerializable()
class NoticeData {

  String title = '';
  String description = '';
  String time = '';



  NoticeData({

    required this.title,
    required this.description,
    required this.time,


  });

  factory NoticeData.fromJson(Map<String, dynamic> json) => _$NoticeDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeDataToJson(this);
}
