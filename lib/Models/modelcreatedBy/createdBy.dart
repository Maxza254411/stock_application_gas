import 'package:json_annotation/json_annotation.dart';

part 'createdBy.g.dart';

@JsonSerializable()
class CreatedBy {
  final int? id;
  final String? firstName;
  final String? lastName;

  CreatedBy(
    this.id,
    this.firstName,
    this.lastName,
  );

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}
