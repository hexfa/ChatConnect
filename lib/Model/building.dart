

import 'package:json_annotation/json_annotation.dart';

part 'building.g.dart';

@JsonSerializable()
class BuildingData {

  String id;
  String name= '';
  String city= '';
  String country = '';
  String address= '';
  String adminName =  '';





  BuildingData({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.address,
    required this.adminName,


  });


  factory BuildingData.fromJson(Map<String, dynamic> json) => _$buildingDataFromJson(json);

  Map<String, dynamic> toJson() => _$PetDataToJson(this);

}