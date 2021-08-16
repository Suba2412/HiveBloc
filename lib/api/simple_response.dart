import 'dart:convert';
import 'package:hive/hive.dart';
part 'simple_response.g.dart';

@HiveType(typeId: 1)

/*BlocApi blocApiFromJson(String str) => BlocApi.fromJson(json.decode(str));

String blocApiToJson(BlocApi data) => json.encode(data.toJson());*/

class BlocApi {
  @HiveField(0)
  int? userId;

  @HiveField(1)
  int? id;

  @HiveField(2)
  String? title;
  BlocApi({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory BlocApi.fromJson(Map<String, dynamic> json) => BlocApi(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
  };
}
