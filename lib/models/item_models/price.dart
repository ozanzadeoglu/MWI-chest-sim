class Price {
  double ask;
  double bid;

  Price({required this.ask, required this.bid});

  // Factory method to create an Item object from JSON
  factory Price.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? prices = json['0'];
    return Price(
      ask: prices?['a'] ?? -1, // Handle missing or null values
      bid: prices?['b']  ?? -1,
    );
  }
}