import 'package:assessment_sep_2024/controllers/topup_controller.dart';
import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Top Up Beneficiary', () {
    final controller = TopUpController();
    final beneficiary = Beneficiary(
      fullname: 'John Smith',
      nickname: 'John',
      phoneNumber: '0501234567',
      isVerified: true,
    );
    final result = controller.topUp(beneficiary, 100);
    expect(result, true);
    expect(controller.userBalance.value, 4899);
    expect(beneficiary.monthlyTopUp, 100);
  });

  test('Top Up Exceeds Limit', () {
    final controller = TopUpController();
    final beneficiary = Beneficiary(
      fullname: 'John Duke',
      nickname: 'Duke',
      phoneNumber: '0543467234',
      isVerified: true,
    );
    final result = controller.topUp(beneficiary, 1100);
    expect(result, false);
  });
}
