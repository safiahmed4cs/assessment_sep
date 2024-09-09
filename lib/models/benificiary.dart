class Beneficiary {
  String fullname;
  String nickname;
  String phoneNumber;
  double monthlyTopUp;

  Beneficiary({
    required this.fullname,
    required this.nickname,
    required this.phoneNumber,
    this.monthlyTopUp = 0.0,
  });
}
