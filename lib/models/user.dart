class User {
  final String userId;
  final String fullName;
  final String mobile;
  final bool isVerified;
  double balance;
  double totalMonthlyTopUp;

  User({
    required this.userId,
    required this.isVerified,
    required this.fullName,
    required this.mobile,
    required this.balance,
    required this.totalMonthlyTopUp,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'mobile': mobile,
        'isVerified': isVerified,
        'balance': balance,
        'totalMonthlyTopUp': totalMonthlyTopUp,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      fullName: json['fullName'],
      mobile: json['mobile'],
      isVerified: json['isVerified'],
      balance: json['balance'],
      totalMonthlyTopUp: json['totalMonthlyTopUp'],
    );
  }

  bool canTopUp(double amount) {
    return (totalMonthlyTopUp + amount) <= 3000 && balance >= amount + 1;
  }
}
