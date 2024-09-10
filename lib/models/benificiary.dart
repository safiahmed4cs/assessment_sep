class Beneficiary {
  String userId;
  String fullname;
  String nickname;
  String phoneNumber;
  double monthlyTopUpAmount;

  Beneficiary({
    required this.userId,
    required this.fullname,
    required this.nickname,
    required this.phoneNumber,
    this.monthlyTopUpAmount = 0.0,
  });

  bool canTopUp(double amount, bool isVerified) {
    double maxLimit = isVerified ? 1000 : 500;
    return (monthlyTopUpAmount + amount) <= maxLimit;
  }
}
