import 'package:json_annotation/json_annotation.dart';

part 'members.g.dart';

@JsonSerializable()
class Members {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? code;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final int? wallet;
  final int? creditEL2;
  final int? creditEL4;
  final int? credit;
  final int? defultcredit;
  final int? limitcredit;
  final bool? active;
  final String? cardSn;
  final String? sn;
  final String? cardType;
  final String? cardActiveDate;
  final DateTime? activeDate;

  Members(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.code,
    this.firstname,
    this.middlename,
    this.lastname,
    this.wallet,
    this.creditEL2,
    this.creditEL4,
    this.credit,
    this.defultcredit,
    this.limitcredit,
    this.active,
    this.cardSn,
    this.cardType,
    this.cardActiveDate,
    this.sn,
    this.activeDate,
  );

  factory Members.fromJson(Map<String, dynamic> json) => _$MembersFromJson(json);

  Map<String, dynamic> toJson() => _$MembersToJson(this);
}
