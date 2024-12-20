import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch {
  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? code;
  final String? name;
  final String? address;

  Branch(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.code,
    this.name,
    this.address
  );

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
