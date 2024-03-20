// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MainModel {
  double walletMoney;
  double lastSpend;
  double totalSpending;
  MainModel({
    required this.walletMoney,
    required this.lastSpend,
    required this.totalSpending,
  });

  MainModel copyWith({
    double? walletMoney,
    double? lastSpend,
    double? totalSpending,
  }) {
    return MainModel(
      walletMoney: walletMoney ?? this.walletMoney,
      lastSpend: lastSpend ?? this.lastSpend,
      totalSpending: totalSpending ?? this.totalSpending,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'walletMoney': walletMoney,
      'lastSpend': lastSpend,
      'totalSpending': totalSpending,
    };
  }

  factory MainModel.fromMap(Map<String, dynamic> map) {
    return MainModel(
      walletMoney: map['walletMoney'] as double,
      lastSpend: map['lastSpend'] as double,
      totalSpending: map['totalSpending'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory MainModel.fromJson(String source) =>
      MainModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MainModel(walletMoney: $walletMoney, lastSpend: $lastSpend, totalSpending: $totalSpending)';

  @override
  bool operator ==(covariant MainModel other) {
    if (identical(this, other)) return true;

    return other.walletMoney == walletMoney &&
        other.lastSpend == lastSpend &&
        other.totalSpending == totalSpending;
  }

  @override
  int get hashCode =>
      walletMoney.hashCode ^ lastSpend.hashCode ^ totalSpending.hashCode;
}
