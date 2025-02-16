import 'package:assessment_sep_2024/controllers/topup_controller.dart';
import 'package:assessment_sep_2024/models/beneficiary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Top Up Beneficiary', () {
    // final controller = TopUpController();
    // final beneficiary = Beneficiary(
    //   userId: '1',
    //   fullname: 'John Smith',
    //   nickname: 'John',
    //   phoneNumber: '0501234567',
    //   beneficiaryId: DateTime.now().toString(),
    // );
    // final result = controller.topUp(beneficiary, 100);
    // expect(result, true);
    // expect(controller.userBalance.value, 4899);
    // expect(beneficiary.monthlyTopUp, 100);
  });

  test('Top Up Exceeds Limit', () {
    final controller = TopUpController();
    final beneficiary = Beneficiary(
      userId: '2',
      fullname: 'John Duke',
      nickname: 'Duke',
      phoneNumber: '0543467234',
      beneficiaryId: DateTime.now().toString(),
    );
    final result = controller.topUp(beneficiary, 1100);
    expect(result, false);
  });
}
