import 'package:http/http.dart' as http;
import 'dart:convert';

class Currencies {
  static final Map<String, String> eur = {'name': 'Euro', 'code': 'EUR'};
  static final Map<String, String> gbp = {
    'name': 'British Pound',
    'code': 'GBP'
  };
  static final Map<String, String> tnd = {
    'name': 'Tunisian Dinar',
    'code': 'TND'
  };
  static final Map<String, String> usd = {'name': 'US Dollar', 'code': 'USD'};

  static List get all => [eur, gbp, tnd, usd];

  Future<double> getConversionRate(String from, String to) async {
    final response = await http.get(
        "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=$from&to_currency=$to&apikey=S0RVM5GZFO2NX32X");
    if (response.statusCode == 200) {
      return double.parse(json.decode(response.body)[0][4]);
    }
    return Future.error(Error());
  }
}
