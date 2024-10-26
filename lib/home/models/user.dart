class UserModel {
  int id;
  String fullName;
  String phone;
    String code;
  List<TransactionsModel> transactions;

  UserModel(
      {required this.fullName,
      required this.id,
      required this.phone,
      required this.code,
      required this.transactions});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullName: json['fullName'],
        id: json['id'],
        code: json['code'],
        phone: json['phone'],
        transactions: transactionsListFromJson(json['transactions']));
  }
}

class TransactionsModel {
  int id;
  String user;

  String type;
  num amount;
  String? repaymentDate;
  String createdAt;

  TransactionsModel({
    required this.id,
    required this.user,
    required this.type,
    required this.amount,
    this.repaymentDate,
    required this.createdAt,
  });
  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
        id: json['id'],
        user: json['user']['fullName'],
        type: json['type'],
        amount: json['amount'],
        repaymentDate: json['repaymentDate'],
        createdAt: json['createdAt']);
  }
}

List<TransactionsModel> transactionsListFromJson(List list) {
  return List<TransactionsModel>.from(
      list.map((el) => TransactionsModel.fromJson(el)));
}
