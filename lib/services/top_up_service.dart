import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:assessment_sep_2024/models/top_up_option.dart';

class TopUpService {
  double userBalance = 5000.0;
  bool isVerified = false;

  List<TopUpOption> topUpOptions = [
    TopUpOption(5),
    TopUpOption(10),
    TopUpOption(20),
    TopUpOption(30),
    TopUpOption(50),
    TopUpOption(75),
    TopUpOption(100),
  ];

  bool topUp(Beneficiary beneficiary, double amount) {
    double maxTopUp = isVerified ? 500 : 1000;
    if (beneficiary.monthlyTopUp + amount > maxTopUp ||
        userBalance < amount + 1) {
      return false;
    }
    userBalance -= (amount + 1);
    beneficiary.monthlyTopUp += amount;
    return true;
  }
}
