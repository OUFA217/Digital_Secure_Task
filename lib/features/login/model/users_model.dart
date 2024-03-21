class UsersModel {
  List<String>? userName;
  List<String>? type;
  List<String>? walletAmount;
  List<String>? walletLastTransactionDate;
  List<String>? lastActivityAmount;
  List<String>? lastActivityDate;
  UsersModel({
    this.userName = const [],
    this.type = const [],
    this.walletAmount = const [],
    this.walletLastTransactionDate = const [],
    this.lastActivityAmount = const [],
    this.lastActivityDate = const [],
  });
}
