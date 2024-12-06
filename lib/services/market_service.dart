import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:mwi_chest_sim/models/item_models/price.dart';

class MarketService {
  Future<Map<String, Price>> fetchMarketData() async {
    final response = await http.get(Uri.parse("https://raw.githubusercontent.com/holychikenz/MWIApi/main/medianmarket.json"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['market'] as Map<String, dynamic>;

      return data.map((key, value) => MapEntry(key, Price.fromJson(value)));
    } else {
      throw Exception('Failed to load market data');
    }
  }
}


