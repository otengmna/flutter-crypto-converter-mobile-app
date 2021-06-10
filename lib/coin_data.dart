import 'package:http/http.dart' as http;

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'secretapikey';
const apiURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future networkStatusCode(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;

      return data;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getCoinRate(String cryptoCoin, String currency) async {
    var data =
        await networkStatusCode('$apiURL/$cryptoCoin/$currency?apikey=$apiKey');
    return data;
  }
}
