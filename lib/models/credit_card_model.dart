import 'package:meta/meta.dart';
import 'dart:convert';


TarjetaCredito tarjetaCreditoModelFromJson(String str) => TarjetaCredito.fromJson(json.decode(str));

String tarjetaModelToJson(TarjetaCredito data) => json.encode(data.toJson());


class TarjetaCredito {

  TarjetaCredito({
    this.id,
    @required this.cardNumberHidden,
    @required this.cardNumber,
    @required this.brand,
    @required this.cvv,
    @required this.expiracyDate,
    @required this.cardHolderName
  });

  int id;
  String cardNumberHidden;
  String cardNumber;
  String brand;
  String cvv;
  String expiracyDate;
  String cardHolderName;
 

  factory TarjetaCredito.fromJson(Map<String, dynamic> json) => TarjetaCredito(
      id: json['id'],
      cardNumberHidden: json['cardNumberHidden'],
      cardNumber: json['cardNumber'],
      brand: json['brand'],
      cvv: json['cvv'],
      expiracyDate: json['expiracyDate'],
      cardHolderName: json['cardHolderName'],
  );

  Map<String, dynamic> toJson() => {
    "cardNumberHidden":cardNumberHidden,
    "cardNumber":cardNumber,
    "brand":brand,
    "cvv":cvv,
    "expiracyDate":expiracyDate,
    "cardHolderName":cardHolderName
  };
}

