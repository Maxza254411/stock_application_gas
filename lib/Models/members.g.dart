// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Members _$MembersFromJson(Map<String, dynamic> json) => Members(
      (json['id'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['code'] as String?,
      json['firstname'] as String?,
      json['middlename'] as String?,
      json['lastname'] as String?,
      (json['wallet'] as num?)?.toInt(),
      (json['creditEL2'] as num?)?.toInt(),
      (json['creditEL4'] as num?)?.toInt(),
      (json['credit'] as num?)?.toInt(),
      (json['defultcredit'] as num?)?.toInt(),
      (json['limitcredit'] as num?)?.toInt(),
      json['active'] as bool?,
      json['cardSn'] as String?,
      json['cardType'] as String?,
      json['cardActiveDate'] as String?,
      json['sn'] as String?,
      json['activeDate'] == null
          ? null
          : DateTime.parse(json['activeDate'] as String),
    );

Map<String, dynamic> _$MembersToJson(Members instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'code': instance.code,
      'firstname': instance.firstname,
      'middlename': instance.middlename,
      'lastname': instance.lastname,
      'wallet': instance.wallet,
      'creditEL2': instance.creditEL2,
      'creditEL4': instance.creditEL4,
      'credit': instance.credit,
      'defultcredit': instance.defultcredit,
      'limitcredit': instance.limitcredit,
      'active': instance.active,
      'cardSn': instance.cardSn,
      'sn': instance.sn,
      'cardType': instance.cardType,
      'cardActiveDate': instance.cardActiveDate,
      'activeDate': instance.activeDate?.toIso8601String(),
    };
