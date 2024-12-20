import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/orderpayment.dart';

part 'paymentorder.g.dart';

@JsonSerializable()
class PaymentOrder {
  final int id;
  final String? orderStatus;
  final double? total;
  final double? discount;
  final double? grandTotal;
  final List<OrderPayment>? orderPayments;

  PaymentOrder(this.id, this.orderStatus, this.total, this.discount, this.grandTotal, this.orderPayments);

  factory PaymentOrder.fromJson(Map<String, dynamic> json) => _$PaymentOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentOrderToJson(this);
}
