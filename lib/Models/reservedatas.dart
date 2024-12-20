import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/members.dart';
import 'package:stock_application_gas/Models/orderitems.dart';
import 'package:stock_application_gas/Models/orderpayment.dart';

part 'reservedatas.g.dart';

@JsonSerializable()
class Reservedatas {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? orderNo;
  DateTime? orderDate;
  String? orderStatus;
  double? total;
  double? discount;
  double? grandTotal;
  double? change;
  double? paid;
  int? deviceId;
  String? receivedStatus;
  int? serviceChargeRate;
  int? serviceCharge;
  double? vat;
  String? Hn;
  String? customerName;
  String? remark;
  String? voidReason;
  String? roomNo;
  Members? member;
  List<Orderitems>? orderItems;
  List<OrderPayment>? orderPayments;

  Reservedatas(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.orderNo,
    this.orderDate,
    this.orderStatus,
    this.total,
    this.discount,
    this.grandTotal,
    this.change,
    this.paid,
    this.deviceId,
    this.receivedStatus,
    this.serviceChargeRate,
    this.serviceCharge,
    this.vat,
    this.Hn,
    this.customerName,
    this.remark,
    this.voidReason,
    this.roomNo,
    this.member,
    this.orderItems,
    this.orderPayments,
  );

  factory Reservedatas.fromJson(Map<String, dynamic> json) => _$ReservedatasFromJson(json);

  Map<String, dynamic> toJson() => _$ReservedatasToJson(this);
}
