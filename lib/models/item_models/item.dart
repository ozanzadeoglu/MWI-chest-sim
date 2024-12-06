import 'package:mwi_chest_sim/models/item_models/price.dart';

//this class represents smth like this;
//60 Sunstone, ask price 35000 bid price 30000
class Item {
  //name of the item
  final String itemName;
  //ask and bid prices of it
  Price? prices;
  //number of items, initially 0 
  int quantity;

  Item({required this.itemName, this.prices, this.quantity = 0});
}