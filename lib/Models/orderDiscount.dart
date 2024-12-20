import 'package:json_annotation/json_annotation.dart';

part 'orderDiscount.g.dart';

@JsonSerializable()
class OrderDiscount {
  final String name;
  final String? description;
  final double? amount;
  final String? code;

  OrderDiscount(this.name, this.description, this.amount, this.code);

  factory OrderDiscount.fromJson(Map<String, dynamic> json) => _$OrderDiscountFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDiscountToJson(this);
}
