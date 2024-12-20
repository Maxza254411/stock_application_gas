import 'package:json_annotation/json_annotation.dart';

part 'orderpayments.g.dart';

@JsonSerializable()
class OrderPayments {
  final int paymentMethodId;
  final double amount;
  final String? remark;

  OrderPayments(
    this.paymentMethodId,
    this.amount,
    this.remark,
  );

  factory OrderPayments.fromJson(Map<String, dynamic> json) => _$OrderPaymentsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPaymentsToJson(this);
}
