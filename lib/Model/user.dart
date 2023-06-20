import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserData {

  String id;
  String name = '';
  String password1 = '';
  String password2 = '';
  String email = '';
  String admin = '';
  String image = '';
  String country = '';
  String city = '';
  String apartment = '';
  String unit = '';
  String apartmentId = '';

  UserData(this.id,{
    required this.name ,
    required this.password1,
    required this.password2,
    required this.email ,
    required this.admin ,
    required this.image,
    required this.country ,
    required this.city ,
    required this.apartment,
    required this.unit,
    required this.apartmentId,

  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}