
import 'package:mwi_chest_sim/models/item_models/shop_item.dart';

class DungeonShop {

      // List of items bought with Chimerical Tokens
    final List<ShopItem> chimericalItems = [
    ShopItem(itemName: 'Chimerical Essence', priceByTokens: 1, tokenType: 'Chimerical Token'),
    ShopItem(itemName: 'Griffin Leather', priceByTokens: 600, tokenType: 'Chimerical Token'),
    ShopItem(itemName: 'Manticore Sting', priceByTokens: 1000, tokenType: 'Chimerical Token'),
    ShopItem(itemName: 'Jackalope Antler', priceByTokens: 1200, tokenType: 'Chimerical Token'),
    ShopItem(itemName: 'Dodocamel Plume', priceByTokens: 3000, tokenType: 'Chimerical Token'),
    ShopItem(itemName: 'Griffin Talon', priceByTokens: 3000, tokenType: 'Chimerical Token'),
  ];

  // List of items bought with Sinister Tokens
  final List<ShopItem> sinisterItems = [
    ShopItem(itemName: 'Sinister Essence', priceByTokens: 1, tokenType: 'Sinister Token'),
    ShopItem(itemName: 'Acrobat\'s Ribbon', priceByTokens: 2000, tokenType: 'Sinister Token'),
    ShopItem(itemName: 'Magician\'s Cloth', priceByTokens: 2000, tokenType: 'Sinister Token'),
    ShopItem(itemName: 'Chaotic Chain', priceByTokens: 3000, tokenType: 'Sinister Token'),
    ShopItem(itemName: 'Cursed Ball', priceByTokens: 3000, tokenType: 'Sinister Token'),
  ];

  // List of items bought with Enchanted Tokens
  final List<ShopItem> enchantedItems = [
    ShopItem(itemName: 'Enchanted Essence', priceByTokens: 1, tokenType: 'Enchanted Token'),
    ShopItem(itemName: 'Royal Cloth', priceByTokens: 2000, tokenType: 'Enchanted Token'),    
    ShopItem(itemName: 'Knight\'s Ingot', priceByTokens: 2000, tokenType: 'Enchanted Token'),
    ShopItem(itemName: 'Bishop\'s Scroll', priceByTokens: 2000, tokenType: 'Enchanted Token'),
    ShopItem(itemName: 'Regal Jewel', priceByTokens: 3000, tokenType: 'Enchanted Token'),
    ShopItem(itemName: 'Sundering Jewel', priceByTokens: 3000, tokenType: 'Enchanted Token'),
  ];

}
