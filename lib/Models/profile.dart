import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String username;
  final String code;
  final String firstName;
  final String lastName;
  String? phoneNumber;
  final bool isActive;
  // Role? role;
  final String fullName;
  Profile(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.code,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.isActive,
    // this.role,
    this.fullName,
  );

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
