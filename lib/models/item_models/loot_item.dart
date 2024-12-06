class LootItem {
  final String name;
  final double probability; // probability  0.5 for %0.5
  final int minQuantity;
  final int maxQuantity;

  LootItem({
    required this.name,
    required this.probability,
    required this.minQuantity,
    required this.maxQuantity,
  });
}
