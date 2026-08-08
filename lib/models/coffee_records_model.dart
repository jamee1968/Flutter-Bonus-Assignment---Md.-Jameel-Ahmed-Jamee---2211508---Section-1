class CoffeeRecordsModel {
  int? id;
  String? title;
  String? des;
  double? amount;
  DateTime? date;
  String? docId;

  CoffeeRecordsModel({
    this.id,
    this.title,
    this.des,
    this.amount,
    this.date,
    this.docId,
  });

  factory CoffeeRecordsModel.fromJson(Map<String, dynamic> json) {
    return CoffeeRecordsModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      des: json['des'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      date: DateTime.parse(json['date'] as String? ?? ''),
      docId: json['doc_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'des': des,
      'amount': amount,
      'date': date?.toIso8601String(),
    };
  }
}