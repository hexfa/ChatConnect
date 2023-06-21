import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceData {
  String category = '';
  String title = '';
  String description = '';
  String image = '';
  String telephone = '';
  String mobile = '';
  String email = '';
  String website = '';
  String instagram = '';
  String facebook = '';
  String twitter = '';
  String linkedin = '';

  ServiceData({
    required this.category,
    required this.title,
    required this.description,
    required this.image,
    required this.telephone,
    required this.mobile,
    required this.email,
    required this.website,
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) =>
      _$ServiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDataToJson(this);
}
