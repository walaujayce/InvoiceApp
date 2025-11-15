import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Business {
  final String id;
  final String? logoUrl;
  final String name;
  final String address;
  final String email;
  final String phone;
  final String website;
  final String paymentInfo;
  final String paypalEmail;
  final String? qrCodeUrl;
  final String? signatureUrl;
  final double totalMoney;
  final int invoiceCount;
  bool isDefault;

  Business({
    String? id,
    required this.name,
    this.logoUrl,
    this.address = "",
    this.email = "",
    this.phone = "",
    this.website = "",
    this.paymentInfo = "",
    this.paypalEmail = "",
    this.qrCodeUrl,
    this.signatureUrl,
    this.totalMoney = 0.0,
    this.invoiceCount = 0,
    this.isDefault = false,
  }) : id = id ?? Uuid().v4();
}
