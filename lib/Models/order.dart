import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/branch.dart';
import 'package:stock_application_gas/Models/device.dart';
import 'package:stock_application_gas/Models/modelcreatedBy/createdBy.dart';
import 'package:stock_application_gas/Models/orderitems.dart';
import 'package:stock_application_gas/Models/orderpayment.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? orderNo;
  final DateTime? orderDate;
  final String? orderStatus;
  final double? vat;
  final double? total;
  final double? discount;
  final double? serviceChargeRate;
  double? grandTotal;
  final double? serviceCharge;
  final double? change;
  final double? paid;
  String? remark;
  final Branch? branch;
  final Device? device;
  final CreatedBy? createdBy;

  // Shift? shift;
  String? roomNo;
  String? customerName;
  String? Hn;
  List<Orderitems>? orderItems;
  List<OrderPayment>? orderPayments;

  Order(
    this.createdAt,
    this.deletedAt,
    this.discount,
    this.grandTotal,
    this.id,
    this.orderDate,
    this.orderNo,
    this.orderStatus,
    // this.shift,
    this.total,
    this.updatedAt,
    this.orderPayments,
    this.orderItems,
    this.change,
    this.paid,
    this.remark,
    this.serviceChargeRate,
    this.serviceCharge,
    this.vat,
    this.branch,
    this.device,
    this.createdBy,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
