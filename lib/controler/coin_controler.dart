import 'package:crypto_with_getx/model/coin_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinController extends GetxController {
  var coinList = <Coin>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoins();
  }

  void fetchCoins() async {
    try {
      isLoading(true);
      errorMessage('');
      var response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        coinList.value = jsonData.map((coin) => Coin.fromJson(coin)).toList();
      } else {
        errorMessage('Failed to load data');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
