import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mwi_chest_sim/models/item_models/price.dart';

class MarketService {
  Future<Map<String, Price>> fetchMarketData() async {
    final response = await http.get(
        Uri.parse("https://www.milkywayidle.com/game_data/marketplace.json"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['marketData'] as Map<String, dynamic>;

      final marketData = data.map((rawKey, value) {
        final newKey = _normalizeKey(rawKey);
        return MapEntry(newKey, Price.fromJson(value));
      });

      // should not do this here but whatever
      marketData["Coin"] = Price(ask: 1, bid: 1);
      marketData["Enchanted Cloak"] = Price(ask: -1, bid: -1);
      marketData["Sinister Cape"] = Price(ask: -1, bid: -1);
      marketData["Chimerical Quiver"] = Price(ask: -1, bid: -1);

      return marketData;
      
    } else {
      throw Exception('Failed to load market data');
    }
  }
}

String _normalizeKey(String rawKey) {
  // 1) Get last path segment (handles leading "/items/..." or "items/..." or "foo/bar/baz")
  final lastSegment =
      rawKey.split('/').where((s) => s.isNotEmpty).toList().isEmpty
          ? rawKey
          : rawKey.split('/').where((s) => s.isNotEmpty).last;

  // 2) Decode percent-encoding (if any)
  final decoded = Uri.decodeComponent(lastSegment);

  // 3) Replace underscores/dashes with spaces, collapse spaces and trim
  final spaced = decoded
      .replaceAll(RegExp(r'[_\-]+'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  // 4) Title-case
  return spaced.split(' ').map((w) {
    if (w.isEmpty) return w;
    final lower = w.toLowerCase();
    return lower[0].toUpperCase() +
        (lower.length > 1 ? lower.substring(1) : '');
  }).join(' ');
}
