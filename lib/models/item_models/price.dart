class Price {
  final double ask;
  final double bid;

  Price({required this.ask, required this.bid});

  // Factory method to create an Item object from JSON
  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      ask: json['ask'] ?? -1, // Handle missing or null values
      bid: json['bid']  ?? -1,
    );
  }
}