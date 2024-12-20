import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/order.dart';
import 'package:stock_application_gas/Models/paymentmethod.dart';

part 'orderpayment.g.dart';

@JsonSerializable()
class OrderPayment {
  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final double? amount;
  final String? remark;
  final String? status;
  Order? order;
  PaymentMethod? paymentMethod;

  OrderPayment(this.id, this.amount, this.createdAt, this.deletedAt, this.order, this.remark, this.status, this.updatedAt, this.paymentMethod);

  factory OrderPayment.fromJson(Map<String, dynamic> json) => _$OrderPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPaymentToJson(this);
}
