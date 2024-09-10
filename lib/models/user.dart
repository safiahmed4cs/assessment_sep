import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  String userId;
  String fullName;
  String mobile;
  bool isVerified;
  double totalMonthlyTopUp;
  Map<String, double> monthlyWallets;

  User({
    required this.userId,
    required this.fullName,
    required this.mobile,
    required this.isVerified,
    required this.totalMonthlyTopUp,
    required this.monthlyWallets,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'fullName': fullName,
        'mobile': mobile,
        'isVerified': isVerified,
        'totalMonthlyTopUp': totalMonthlyTopUp,
        'monthlyWallets': monthlyWallets,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      fullName: json['fullName'],
      mobile: json['mobile'],
      isVerified: json['isVerified'],
      totalMonthlyTopUp: json['totalMonthlyTopUp'],
      monthlyWallets: Map<String, double>.from(json['monthlyWallets']),
    );
  }

  double getTotalAmountUsedInMonth(String month) {
    return monthlyWallets[month] ?? 0;
  }

  double getBalanceAmountInMonth(String month) {
    return 3000 - getTotalAmountUsedInMonth(month);
  }

  bool canTopUp(double amount, String month) {
    final totalUsedThisMonth = getTotalAmountUsedInMonth(month);
    final remainingBalance = 3000 - totalUsedThisMonth;

    return remainingBalance >= amount + 1;
  }

  Future<void> topUp(double amount, String month) async {
    final totalUsedThisMonth = getTotalAmountUsedInMonth(month);
    final remainingBalance = 3000 - totalUsedThisMonth;

    if (remainingBalance < amount + 1) {
      throw Exception('Insufficient monthly wallet balance');
    }

    totalMonthlyTopUp += amount;
    monthlyWallets[month] = totalUsedThisMonth + amount;

    // Save the user data to the shared preferences
    await saveUserData();
  }

  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(toJson());
    await prefs.setString('current_user', userData);
  }
}
