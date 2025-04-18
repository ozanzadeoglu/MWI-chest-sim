import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mwi_chest_sim/models/item_models/item.dart';
import 'package:mwi_chest_sim/models/item_models/loot_item.dart';
import 'package:mwi_chest_sim/models/item_models/price.dart';
import 'package:mwi_chest_sim/models/item_models/shop_item.dart';
import 'package:mwi_chest_sim/services/market_service.dart';
import 'package:mwi_chest_sim/data/drop_tables.dart';
import 'package:mwi_chest_sim/data/dungeon_shop.dart';

class HomeViewModel extends ChangeNotifier {
  late Map<String, Price> _marketData;
  final _chestQuantityEditingController = TextEditingController();
  final _clearTimeController = TextEditingController();

  bool isSimulationOnProgress = false;
  double currentSimulationProgress = 0;

  String currentChest = "Pirate Chest";
  final DropTables dropTables = DropTables();
  final DungeonShop dungeonShop = DungeonShop();
  var chestDrops = <String, Item>{};

  //if false expenses are calculated from bid prices
  //else calculated from ask prices
  bool areExpensesCalculatedFromAsk = true;
  bool areDropsCalculatedFromAsk = true;

  //clear time is a hour by default
  int clearTimeInMinutes = 60;

  int chestQuantity = 0;
  double totalRevenue = 0;
  double totalExpense = 0;
  double totalProfit = 0;
  double totalProfitPerHour = 0;

  TextEditingController get clearTimeController => _clearTimeController;
  get marketData => _marketData;
  TextEditingController get chestQuantityEditingController =>
      _chestQuantityEditingController;

  HomeViewModel() {
    //fetches market data when class is first created
    fetchMarketData();
  }

  //fetches market data, and adds untradeables to data after that
  void fetchMarketData() async {
    final MarketService marketService = MarketService();
    final response = await marketService.fetchMarketData();
    _marketData = response;
    notifyListeners();
    //calculate untradable's after initializing marketData
    determineTokenPrices();
    determineLargeTreasureChestPrice();
    notifyListeners();
  }

  //changes current chosen chest,
  void changeCurrentChest(String newChestName) {
    currentChest = newChestName;
    notifyListeners();
  }

  void updateClearTimeInMinutes(int clearTime) {
    clearTimeInMinutes = clearTime;
    notifyListeners();
  }

  void openChest(int chestCount) async {
    isSimulationOnProgress = true;
    notifyListeners();

    var newChestDrops = <String, Item>{};
    late final List<LootItem> dropTable;

    // Choose the dropTable of chosenChest
    switch (currentChest) {
      case "Sinister Chest":
        dropTable = dropTables.sinisterChestDropTable;
        break;
      case "Chimerical Chest":
        dropTable = dropTables.chimericalChestDropTable;
        break;
      case "Enchanted Chest":
        dropTable = dropTables.enchantedChestDropTable;
        break;
      case "Pirate Chest":
        dropTable = dropTables.pirateChestDropTable;
        break;
    }

    //simulated chest count in one loop can decrease chunksize for swifter
    //progress indicator animationbut this costs simulation speed
    //because of the progress indicator rebuild,
    //const int chunkSize = 1000;

    //upgrade/solution to problem above, If chestCount is more than 100k
    //chunk size is fixed to around %1 of chestCount so progress indicator
    //rebuilds every time it's simulated %1 which makes simulation speed much higher
    //for large amount of chests like 1, 10M and still has a decent animation.
    //Although when a chunk is big that it takes a long time animation quality
    //drops severly ex 1M, 100M
    final int chunkSize = (chestCount >= 100000) ? chestCount ~/ 100 : 1000;
    //total simulated chest amount
    int simulated = 0;

    while (simulated < chestCount) {
      final int end = (simulated + chunkSize > chestCount)
          ? chestCount
          : simulated + chunkSize;

      for (int i = simulated; i < end; i++) {
        for (var item in dropTable) {
          if (Random().nextDouble() * 100 < item.probability) {
            int quantity = item.minQuantity +
                Random().nextInt((item.maxQuantity - item.minQuantity) + 1);
            if (newChestDrops.containsKey(item.name)) {
              newChestDrops[item.name]!.quantity += quantity;
            } else {
              newChestDrops[item.name] =
                  Item(itemName: item.name, quantity: quantity);
            }
          }
        }
      }
      //update simulated chest amount
      simulated = end;
      currentSimulationProgress = simulated / chestCount;
      notifyListeners();

      //although empty, this await gives time for UI to
      //rebuild. Could say it prevents event loop to
      //only focus on openChest method by distrupting it
      await Future.delayed(const Duration());
    }

    //give new referance to chestDrops so selector knows it's changed and updates accordingly.
    chestDrops = Map.from(newChestDrops);
    chestQuantity = chestCount;
    calculateAllEconomics();
    isSimulationOnProgress = false;
    notifyListeners();
  }

  //all calculations are together for simplicity
  void calculateAllEconomics() {
    calculateTotalRevenue();
    calculateTotalExpenes();
    calculateTotalProfitAndHourlyProfit();
    notifyListeners();
  }

  void calculateTotalRevenue() {
    totalRevenue = 0;

    for (var itemMapEntry in chestDrops.entries) {
      double askPrice = marketData[itemMapEntry.key].ask;
      double bidPrice = marketData[itemMapEntry.key].bid;

      //so the logic is, if user wants the revenue generated from ask prices
      //but if there's no one selling in ask's, the bid price is used for calculation,
      //same thing happens with bid calculation(3rd option)
      if (areDropsCalculatedFromAsk && askPrice != -1) {
        totalRevenue += askPrice * itemMapEntry.value.quantity;
      } else if (!areDropsCalculatedFromAsk && bidPrice != -1) {
        totalRevenue += bidPrice * itemMapEntry.value.quantity;
      } else {
        totalRevenue += max(askPrice, bidPrice) * itemMapEntry.value.quantity;
      }

      //initialize uninitialized fiels of the Item class objects.
      itemMapEntry.value.prices = Price(ask: askPrice, bid: bidPrice);
    }
  }

  void calculateTotalExpenes() {
    String entryKeyName = "";
    String chestKeyName = "";

    switch (currentChest) {
      case "Chimerical Chest":
        entryKeyName = "Chimerical Entry Key";
        chestKeyName = "Chimerical Chest Key";
        break;
      case "Sinister Chest":
        entryKeyName = "Sinister Entry Key";
        chestKeyName = "Sinister Chest Key";
        break;
      case "Enchanted Chest":
        entryKeyName = "Enchanted Entry Key";
        chestKeyName = "Enchanted Chest Key";
        break;
      case "Pirate Chest":
        entryKeyName = "Pirate Entry Key";
        chestKeyName = "Pirate Chest Key";
    }

    if (areExpensesCalculatedFromAsk) {
      totalExpense =
          (marketData[entryKeyName].ask + marketData[chestKeyName].ask) *
              chestQuantity;
    } else {
      totalExpense =
          (marketData[entryKeyName].bid + marketData[chestKeyName].bid) *
              chestQuantity;
    }
  }

  void calculateTotalProfitAndHourlyProfit() {
    totalProfit = totalRevenue - totalExpense;

    double profitPerChest = totalProfit / chestQuantity;
    double clearsPerHour = 60 / clearTimeInMinutes;

    totalProfitPerHour = profitPerChest * clearsPerHour;
  }

  //tokens are untradeable but, it can be used to exchange
  //tradable items from the dungeon shop that's why we can
  //determine a "price" for it.
  void determineTokenPrices() {
    double askTokenPrice = 0;
    double bidTokenPrice = 0;
    final Map<String, List<ShopItem>> tokensAndShops = {
      "Chimerical Token": dungeonShop.chimericalItems,
      "Sinister Token": dungeonShop.sinisterItems,
      "Enchanted Token": dungeonShop.enchantedItems,
      "Pirate Token": dungeonShop.pirateItems
    };
    for (var token in tokensAndShops.keys) {
      askTokenPrice = 0;
      bidTokenPrice = 0;
      for (var item in tokensAndShops[token]!) {
        double askPrice =
            ((marketData[item.itemName].ask / item.priceByTokens));
        double bidPrice =
            ((marketData[item.itemName].bid / item.priceByTokens));
        if (askTokenPrice < askPrice) {
          askTokenPrice = askPrice.ceil().toDouble();
        }
        if (bidTokenPrice < bidPrice) {
          bidTokenPrice = bidPrice.ceil().toDouble();
        }
      }
      marketData[token] = Price(ask: askTokenPrice, bid: bidTokenPrice);
    }
  }

  //not simulated, probabilistic calculation unlike
  //opening chests
  void determineLargeTreasureChestPrice() {
    double askTotalPrice = 0;
    double bidTotalPrice = 0;
    for (var item in dropTables.largeTreasureChest) {
      //used abs at the end because coin's price is -1 in the api.
      askTotalPrice += ((item.minQuantity + item.maxQuantity) / 2) *
          item.probability /
          100 *
          (marketData[item.name].ask).abs();
      bidTotalPrice += ((item.minQuantity + item.maxQuantity) / 2) *
          item.probability /
          100 *
          (marketData[item.name].bid).abs();
    }
    marketData["Large Treasure Chest"] =
        Price(ask: askTotalPrice, bid: bidTotalPrice);
  }

  void calculateEditedEconomics() {
    totalRevenue = 0;
    for (var itemMapEntry in chestDrops.entries) {
      double askPrice = itemMapEntry.value.prices!.ask;
      double bidPrice = itemMapEntry.value.prices!.bid;

      //so the logic is, if user wants the revenue generated from ask prices
      //but if there's no one selling in ask's, the bid price is used for calculation,
      //same thing happens with bid calculation(3rd option)
      if (areDropsCalculatedFromAsk && askPrice != -1) {
        totalRevenue += askPrice * itemMapEntry.value.quantity;
      } else if (!areDropsCalculatedFromAsk && bidPrice != -1) {
        totalRevenue += bidPrice * itemMapEntry.value.quantity;
      } else {
        totalRevenue += max(askPrice, bidPrice) * itemMapEntry.value.quantity;
      }
    }
    calculateTotalExpenes();
    calculateTotalProfitAndHourlyProfit();
    notifyListeners();
  }

  //this thing formats 12345,123 to
  //12.345,123 thank you chat-gpt
  String formatDouble(String input) {
    List<String> parts = input.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Keep only the first digit of the decimal part
    decimalPart = decimalPart.isNotEmpty ? decimalPart[0] : '0';

    // Add thousands separator to the integer part
    integerPart = integerPart.replaceAllMapped(
      RegExp(r'\d(?=(?:\d{3})+$)'),
      (match) => '${match.group(0)}.',
    );

    // Add decimal separator
    return '$integerPart,$decimalPart';
  }

  //formats 12345 to 12.345
  String formatInteger(String input) {
    // Add thousands separators
    String formatted = input.replaceAllMapped(
      RegExp(r'\d(?=(?:\d{3})+$)'), // Matches digits in groups of thousands
      (match) => '${match.group(0)}.', // Add '.' as a separator
    );
    return formatted;
  }

  //formats Knight's aegis to knights_aegis
  //so that I can use the returned string to
  //retrive svg files,
  String formatForAssets(String input) {
    return input
        .toLowerCase() // Convert to lowercase
        .replaceAll(RegExp(r"[^\w\s]"),
            '') // Remove non-alphanumeric characters except spaces
        .replaceAll(' ', '_');
  }
}
