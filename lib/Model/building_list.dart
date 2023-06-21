import 'package:json_annotation/json_annotation.dart';

part 'building_list.g.dart';

@JsonSerializable()
class BuildingListData {
  String id='';
  String name = '';



  BuildingListData({
    required this.id,
    required this.name,


  });

  factory BuildingListData.fromJson(Map<String, dynamic> json) => _$BuildingListDataFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingListDataToJson(this);
}
