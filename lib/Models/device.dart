import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/branch.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? code;
  final String? name;
  final Branch? branch;

  Device(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.code,
    this.name,
    this.branch,
  );

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
