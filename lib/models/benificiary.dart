class Beneficiary {
  String benificiaryId;
  String userId;
  String fullname;
  String nickname;
  String phoneNumber;
  double monthlyTopUpAmount;

  Beneficiary({
    required this.benificiaryId,
    required this.userId,
    required this.fullname,
    required this.nickname,
    required this.phoneNumber,
    this.monthlyTopUpAmount = 0.0,
  });

  Map<String, dynamic> toJson() => {
        'benificiaryId': benificiaryId,
        'userId': userId,
        'fullname': fullname,
        'nickname': nickname,
        'phoneNumber': phoneNumber,
        'monthlyTopUpAmount': monthlyTopUpAmount,
      };

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      userId: json['userId'],
      benificiaryId: json['benificiaryId'],
      fullname: json['fullname'],
      nickname: json['nickname'],
      phoneNumber: json['phoneNumber'],
      monthlyTopUpAmount: json['monthlyTopUpAmount'],
    );
  }

  bool canTopUp(double amount, bool isVerified) {
    double maxLimit = isVerified ? 1000 : 500;
    return (monthlyTopUpAmount + amount) <= maxLimit;
  }
}
