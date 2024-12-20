import 'package:json_annotation/json_annotation.dart';

part 'paymentqr.g.dart';

@JsonSerializable()
class PaymentQr {
  final double? total;
  final DateTime? expiredate;
  final String? image;

  PaymentQr(this.total, this.expiredate, this.image);

  factory PaymentQr.fromJson(Map<String, dynamic> json) => _$PaymentQrFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentQrToJson(this);
}
