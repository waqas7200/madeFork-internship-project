import 'package:flutter/material.dart';

class CreditCardModel {
  final String cardNumber;
  final String holderName;
  final Color cardColor;
  final String brand;

  CreditCardModel({
    required this.cardNumber,
    required this.holderName,
    required this.cardColor,
    required this.brand,
  });

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      cardNumber: map['cardNumber'] ?? '',
      holderName: map['holderName'] ?? '',
      brand: map['brand'] ?? 'VISA',
      cardColor: Color(int.parse(map['cardColor'] ?? "0xFF2D3436")),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'holderName': holderName,
      'cardColor': cardColor.value.toString(),
      'brand': brand,
    };
  }
}

class PaymentOptionModel {
  final String title;
  final String balance;
  final IconData icon;

  PaymentOptionModel({
    required this.title,
    required this.balance,
    required this.icon,
  });

  factory PaymentOptionModel.fromMap(Map<String, dynamic> map) {
    return PaymentOptionModel(
      title: map['title'] ?? '',
      balance: map['balance'] ?? '',
      icon: IconData(map['iconCode'] ?? 57585, fontFamily: 'MaterialIcons'),
    );
  }
}