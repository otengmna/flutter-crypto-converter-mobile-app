import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';

  CoinData coinData = CoinData();

  String exchangeRate = '?';
  String cryptoCoin;
  String currency;

  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        exchangeRate = '0.0';
        return;
      }
      cryptoCoin = jsonDecode(data)['asset_id_base'];
      currency = jsonDecode(data)['asset_id_quote'];
      exchangeRate = (jsonDecode(data)['rate']).toStringAsFixed(3);
    });
  }

  CupertinoPicker iosDropDown(List<String> listData) {
    List<Widget> listItems = [];

    for (String x in listData) {
      var item = Text(x);
      listItems.add(item);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedValue) async {
        setState(() {
          var item = listData[selectedValue];
          if (listData.length > 5) {
            selectedCurrency = item;
          } else {
            selectedCrypto = item;
          }
        });

        var info = await coinData.getCoinRate(selectedCrypto, selectedCurrency);
        updateUI(info);
        print(exchangeRate);
      },
      children: listItems,
      // [
      //   Text('USD'),
      // ],
    );
  }

  DropdownButton<String> androidDropdown(List<dynamic> listData) {
    List<DropdownMenuItem<String>> listItems = [];
    for (String x in listData) {
      //Android view
      var item = DropdownMenuItem(
        child: Text(x),
        value: x,
      );
      listItems.add(item);
    }

    return DropdownButton<String>(
      //starting value
      value: selectedCurrency,
      items: listItems,
      onChanged: (value) async {
        setState(() {
          if (listData.length > 5) {
            selectedCurrency = value;
          } else {
            selectedCrypto = value;
          }
        });
        var info = await coinData.getCoinRate(selectedCrypto, selectedCurrency);
        updateUI(info);
        print(exchangeRate);
      },
    );
  }

  Widget getPicker(List<String> list) {
    if (Platform.isAndroid) {
      return androidDropdown(list);
    } else if (Platform.isIOS) {
      return iosDropDown(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCrypto = $exchangeRate $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Row(
              children: [
                Expanded(
                  child: getPicker(cryptoList),
                ),
                Expanded(
                  child: getPicker(currenciesList),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
