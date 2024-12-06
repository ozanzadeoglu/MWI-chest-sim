
//drop tables of every chest.
import 'package:mwi_chest_sim/models/item_models/loot_item.dart';

class DropTables {

  List<LootItem> enchantedChestDropTable = [
    LootItem(name: 'Enchanted Essence', probability: 100, minQuantity: 400, maxQuantity: 800),
    LootItem(name: 'Enchanted Essence', probability: 5.0, minQuantity: 2000, maxQuantity: 4000),
    LootItem(name: 'Enchanted Token', probability: 100, minQuantity: 250, maxQuantity: 500),
    LootItem(name: 'Enchanted Token', probability: 5.0, minQuantity: 1500, maxQuantity: 3000),
    LootItem(name: 'Large Treasure Chest',  probability: 30.0,  minQuantity: 1,maxQuantity: 7),
    LootItem(name:'Amethyst', probability: 60.0, minQuantity: 5, maxQuantity: 20),
    LootItem(name:'Sunstone', probability: 50.0, minQuantity: 1, maxQuantity: 5),
    LootItem(name:'Crippling Slash', probability: 50.0, minQuantity: 1, maxQuantity: 2),
    LootItem(name:'Penetrating Shot', probability: 50.0, minQuantity: 1, maxQuantity: 2),
    LootItem(name:'Arcane Reflection', probability: 50.0, minQuantity: 1, maxQuantity: 2),
    LootItem(name:'Mana Spring', probability: 50.0, minQuantity: 1, maxQuantity: 2),
    LootItem(name:'Knight\'s Ingot', probability: 4.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Bishop\'s Scroll', probability: 4.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Royal Cloth', probability: 4.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Regal Jewel', probability: 2.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Sundering Jewel', probability: 2.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Enchanted Chest Key', probability: 2.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Enchanted Cloak', probability: 4.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Knight\'s Aegis', probability: 0.2, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Bishop\'s Codex', probability: 0.2, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Royal Water Robe Top', probability: 0.04, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Royal Water Robe Bottoms', probability: 0.04, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Royal Nature Robe Top', probability: 0.04, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Royal Nature Robe Bottoms', probability: 0.04, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Royal Fire Robe Top', probability: 0.04, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Royal Fire Robe Bottoms', probability: 0.04, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Regal Sword', probability: 0.05, minQuantity: 1, maxQuantity: 1),
    LootItem(name:'Sundering Crossbow', probability: 0.05, minQuantity: 1, maxQuantity: 1),
  ] ;

  final List<LootItem> sinisterChestDropTable = [
    LootItem(name: 'Sinister Essence', probability: 100.0, minQuantity: 400, maxQuantity: 800),
    LootItem(name: 'Sinister Essence', probability: 5.0, minQuantity: 2000, maxQuantity: 4000),
    LootItem(name: 'Sinister Token', probability: 100.0, minQuantity: 250, maxQuantity: 500),
    LootItem(name: 'Sinister Token', probability: 5.0, minQuantity: 1500, maxQuantity: 3000),
    LootItem(name: 'Large Treasure Chest', probability: 30.0, minQuantity: 1, maxQuantity: 6),
    LootItem(name: 'Garnet', probability: 60.0, minQuantity: 5, maxQuantity: 20),
    LootItem(name: 'Sunstone', probability: 50.0, minQuantity: 1, maxQuantity: 3),
    LootItem(name: 'Penetrating Strike', probability: 50.0, minQuantity: 1, maxQuantity: 2),
    LootItem(name: 'Pestilent Shot', probability: 50.0, minQuantity: 1, maxQuantity: 2),
    LootItem(name: 'Smoke Burst', probability: 50.0, minQuantity: 1, maxQuantity: 2),
    LootItem(name: 'Acrobat\'s Ribbon', probability: 4.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Magician\'s Cloth', probability: 4.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Chaotic Chain', probability: 2.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Sinister Chest Key', probability: 2.0, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Sinister Cape', probability: 4, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Acrobatic Hood', probability: 0.2, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Magician\'s Hat', probability: 0.2, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Chaotic Flail', probability: 0.05, minQuantity: 1, maxQuantity: 1),
    LootItem(name: 'Cursed Bow', probability: 0.05, minQuantity: 1, maxQuantity: 1),
];

final List<LootItem> chimericalChestDropTable = [
  LootItem(name: 'Chimerical Essence', probability: 100.0, minQuantity: 400, maxQuantity: 800),
  LootItem(name: 'Chimerical Essence', probability: 5.0, minQuantity: 2000, maxQuantity: 4000),
  LootItem(name: 'Chimerical Token', probability: 100.0, minQuantity: 250, maxQuantity: 500),
  LootItem(name: 'Chimerical Token', probability: 5.0, minQuantity: 1500, maxQuantity: 3000),
  LootItem(name: 'Large Treasure Chest', probability: 30.0, minQuantity: 1, maxQuantity: 5),
  LootItem(name: 'Jade', probability: 60.0, minQuantity: 5, maxQuantity: 20),
  LootItem(name: 'Sunstone', probability: 50.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Crippling Slash', probability: 50.0, minQuantity: 1, maxQuantity: 2),
  LootItem(name: 'Pestilent Shot', probability: 50.0, minQuantity: 1, maxQuantity: 2),
  LootItem(name: 'Griffin Leather', probability: 10.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Manticore Sting', probability: 6.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Jackalope Antler', probability: 5.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Dodocamel Plume', probability: 2.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Griffin Talon', probability: 2.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Chimerical Chest Key', probability: 2.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Chimerical Quiver', probability: 3.0, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Griffin Tunic', probability: 0.3, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Griffin Chaps', probability: 0.3, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Manticore Shield', probability: 0.3, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Jackalope Staff', probability: 0.2, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Dodocamel Gauntlets', probability: 0.15, minQuantity: 1, maxQuantity: 1),
  LootItem(name: 'Griffin Bulwark', probability: 0.05, minQuantity: 1, maxQuantity: 1),
];

List<LootItem> largeTreasureChest = [
  LootItem(name: "Coin", probability: 100, minQuantity: 30000, maxQuantity: 60000),
  LootItem(name: "Coin", probability: 10.0, minQuantity: 150000, maxQuantity: 300000),
  LootItem(name: "Pearl", probability: 60.0, minQuantity: 1, maxQuantity: 3),
  LootItem(name: "Amber", probability: 40, minQuantity: 1, maxQuantity: 3),
  LootItem(name: "Garnet", probability: 40, minQuantity: 1, maxQuantity: 3),
  LootItem(name: "Jade", probability: 40, minQuantity: 1, maxQuantity: 3),
  LootItem(name: "Moonstone", probability: 40, minQuantity: 1, maxQuantity: 2),
];

}
