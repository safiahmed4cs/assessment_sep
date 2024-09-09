class Beneficiary {
  String fullname;
  String nickname;
  String phoneNumber;
  bool isVerified = false;
  double monthlyTopUp;

  Beneficiary({
    required this.fullname,
    required this.nickname,
    required this.phoneNumber,
    required this.isVerified,
    this.monthlyTopUp = 0.0,
  });
}
