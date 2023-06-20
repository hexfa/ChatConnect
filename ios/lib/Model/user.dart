import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserData {

  String id;
  String name = '';
  late String lastName = '';

  String password1 = '';
  String password2 = '';
  String number= '';
  String email = '';
  String city = '';
  String day;
  String month;
  String year;

  UserData(this.id,{
    required this.name ,
    this.lastName = '' ,

    required this.password1,
    required this.password2,
    required this.number ,
    required this.email ,
    required this.city ,
    required this.day,
    required this.month,
    required this.year,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}