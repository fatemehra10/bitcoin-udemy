// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
 final String cryptoTyped ;
 final String currencyTyped;
 final String value;

  const CryptoCard({Key? key,required this.value ,required this.cryptoTyped, required this.currencyTyped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          child: Text(
            "1 $cryptoTyped = $value $currencyTyped",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
