class BinancePrice {
  final String symbol;
  final String price;

  const BinancePrice({required this.symbol, required this.price});

  factory BinancePrice.fromJson(Map<String, dynamic>json) {
    return BinancePrice(symbol: json['symbol'], price: json['price']);
  }
}