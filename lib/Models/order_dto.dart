import 'package:json_annotation/json_annotation.dart';

import 'package:stock_application_gas/Models/orderitemsdto1.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  double total;
  int? deviceId;
  int? branchId;
  double grandtotal;
  double serviceCharge;
  double serviceChargeRate;
  double vat;
  String? Hn;
  String? customerName;
  String? roomNo;
  String? remark;
  final List<OrderItemsDto1>? orderItems;

  OrderDto(
    this.total,
    this.deviceId,
    this.branchId,
    this.remark,
    this.grandtotal,
    this.serviceCharge,
    this.serviceChargeRate,
    this.vat,
    this.Hn,
    this.customerName,
    this.roomNo,
    this.orderItems,
  );

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);

  int sumQuantity() {
    return orderItems?.fold(0, (sum, curr) => sum! + curr.quantity) ?? 0;
  }
}
