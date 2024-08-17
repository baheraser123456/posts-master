// To parse this JSON data, do
//
//     final apiposts = apipostsFromJson(jsonString);

import 'dart:convert';

Apiposts apipostsFromJson(String str) => Apiposts.fromJson(json.decode(str));

String apipostsToJson(Apiposts data) => json.encode(data.toJson());

class Apiposts {
  final int? id;
  final String? title;
  final String? body;
  final int? userId;
  final List<String>? tags;
  final int? reactions;

  Apiposts({
    this.id,
    this.title,
    this.body,
    this.userId,
    this.tags,
    this.reactions,
  });

  factory Apiposts.fromJson(Map<String, dynamic> json) => Apiposts(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        reactions: json["reactions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "reactions": reactions,
      };
}
