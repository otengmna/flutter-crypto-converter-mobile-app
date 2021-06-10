import 'package:flutter/material.dart';
import 'coin_data.dart';

class DropDown {
  String selectedCurrency = 'USD';
  String exchangeRate = '?';
  String cryptoCoin;
  String currency;
  List<String> list;

  DropDown(this.list);

  CoinData coinData = CoinData();
}
