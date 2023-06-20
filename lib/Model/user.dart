import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserData {

  String id;
  String name = '';
  String password1 = '';
  String password2 = '';
  String email = '';

  UserData(this.id,{
    required this.name ,
    required this.password1,
    required this.password2,
    required this.email ,

  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}