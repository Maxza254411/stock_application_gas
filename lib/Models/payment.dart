import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? name;
  final String? name_2;
  final String? type;
  final String? icon;

  Payment(this.id, this.createdAt, this.updatedAt, this.deletedAt, this.name, this.type, this.icon, this.name_2);

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
