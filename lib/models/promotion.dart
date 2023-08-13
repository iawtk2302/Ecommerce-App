class Promotion {
  final String code;
  final String content;
  final String imgUrl;
  final int amount;
  final String type;
  final double minimumOrderValue;
  final double maximumDiscount;
  final DateTime startTime;
  final DateTime endTime;
  Promotion({
    required this.code,
    required this.content,
    required this.imgUrl,
    required this.amount,
    required this.type,
    required this.minimumOrderValue,
    required this.maximumDiscount,
    required this.startTime,
    required this.endTime,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      code: json['code'],
      content: json['content'],
      imgUrl: json['imgUrl'],
      amount: json['amount'] ?? 0,
      type: json['type'],
      minimumOrderValue: json['minimumOrderValue']?.toDouble() ?? -1.0,
      maximumDiscount: json['maximumDiscount']?.toDouble() ?? -1.0,
      startTime: json['startTime'].toDate(),
      endTime: json['endTime'].toDate(),
    );
  }
}
