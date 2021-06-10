import 'package:flutter/material.dart';

void main() {
  dropDownCupertino(currenciesList);
}

void dropDownCupertino(List<String> listData) {
  List<Widget> listItems = [];
  for (String x in listData) {
    var item = Text(x);
    listItems.add(item);
  }
  print(listItems);
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
