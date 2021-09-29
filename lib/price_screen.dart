// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bitcoin/coin_data.dart';
import 'package:bitcoin/crypto_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";

  CoinData coin = CoinData();

  DropdownButton androidDropDownButton() {
    List<DropdownMenuItem> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton(
      elevation: 5,
      value: selectedCurrency,
      onChanged: (dynamic value) {
        setState(() {
          selectedCurrency = value;
        });
      },
      items: dropdownItems,
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItem = [];
    for (String currency in currenciesList) {
      var newItem = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      pickerItem.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 45,
      onSelectedItemChanged: (value) {
        selectedCurrency = value.toString();
      },
      children: pickerItem,
      backgroundColor: Colors.lightBlueAccent,
    );
  }

  Map<String, String> value = {};

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      print(data);
      isWaiting = false;
      setState(() {
        value = data;
        print(value);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  List<Widget> getCard() {
    List<Widget> Card = [];
    for (String crypto in cryptoList) {
      Card.add(CryptoCard(
          value: isWaiting ? '?' : value[crypto].toString(),
          cryptoTyped: crypto,
          currencyTyped: selectedCurrency));
    }
    return Card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "🤑 Coin Ticker",
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCard(),
          ),
          Container(
            height: 150,
            color: Colors.lightBlueAccent,
            child: Center(
                child: Platform.isIOS ? iOSPicker() : androidDropDownButton()),
          )
        ],
      ),
    );
  }
}
