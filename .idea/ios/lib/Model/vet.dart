import 'package:json_annotation/json_annotation.dart';

part 'vet.g.dart';

@JsonSerializable()
class VetData {

  String id;
  String name = '';
  String password = '';
  String email = '';
  String number= '';
  String city = '';
  String cityShop = '';
  String profession = '';
  String expertise = '';
  String jobTitle = '';
  String shopName = '';
  String nit = '';
  String direction = '';
  String servicesRendered = '';
  late String image = '';

  VetData(this.id,{required this.name ,
    required this.password,
    required this.email,
    required this.number,
    required this.city,
    required this.cityShop,
    required this.profession,
    required this.expertise,
    required this.jobTitle,
    required this.shopName,
    this.image = '',
    required this.nit,
    required this.direction,
    required this.servicesRendered,
  });

  factory VetData.fromJson(Map<String, dynamic> json) => _$VetDataFromJson(json);

  Map<String, dynamic> toJson() => _$VetDataToJson(this);

}
