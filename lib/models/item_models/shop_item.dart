
class ShopItem {
  final String itemName;
  //A Sundering Jewel costs 3000 tokens, 
  //so priceByTokens would be 3000.
  final int priceByTokens;
  final String tokenType;

  ShopItem({required this.itemName, required this.priceByTokens, required this.tokenType});
}