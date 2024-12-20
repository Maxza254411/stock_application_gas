// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      (json['id'] as num).toInt(),
      DateTime.parse(json['createdAt'] as String),
      DateTime.parse(json['updatedAt'] as String),
      json['username'] as String,
      json['code'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['phoneNumber'] as String?,
      json['isActive'] as bool,
      json['fullName'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'username': instance.username,
      'code': instance.code,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'isActive': instance.isActive,
      'fullName': instance.fullName,
    };
