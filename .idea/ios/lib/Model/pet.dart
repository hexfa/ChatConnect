

import 'package:json_annotation/json_annotation.dart';

part 'pet.g.dart';

@JsonSerializable()
class PetData {

  String id;
  String name= '';
  String breed= '';
  String petType = '';
  String sex= '';
  String day =  '';
  String month = '';
  String year = '';
  final String image;
  final String size;



  PetData(this.id,{
    required this.name,
    required this.breed,
    required this.petType,
    required this.sex,
    required this.day,
    required this.month,
    required this.year,
    this.image = '',
    this.size = '',
  });


  factory PetData.fromJson(Map<String, dynamic> json) => _$PetDataFromJson(json);

  Map<String, dynamic> toJson() => _$PetDataToJson(this);

}