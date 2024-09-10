class History {
  String beneficiaryId;
  String userId;
  String fullName;
  String nickname;
  String amount;
  String date;
  String phoneNumber;

  History({
    required this.beneficiaryId,
    required this.userId,
    required this.fullName,
    required this.nickname,
    required this.amount,
    required this.date,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        'beneficiaryId': beneficiaryId,
        'userId': userId,
        'fullName': fullName,
        'nickname': nickname,
        'amount': amount,
        'date': date,
        'phoneNumber': phoneNumber,
      };

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      userId: json['userId'],
      beneficiaryId: json['beneficiaryId'],
      amount: json['amount'],
      date: json['date'],
      phoneNumber: json['phoneNumber'],
      fullName: json['fullName'],
      nickname: json['nickname'],
    );
  }
}
