import 'package:assessment_sep_2024/controllers/benificiary_controller.dart';
import 'package:assessment_sep_2024/controllers/user_controller.dart';
import 'package:assessment_sep_2024/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserController userController = Get.find<UserController>();
  final BeneficiaryController beneficiaryController =
      Get.find<BeneficiaryController>();

  @override
  Widget build(BuildContext context) {
    // userController.clearSession();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Select User",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                height: 2,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    User user = User(
                      userId: '1',
                      fullName: 'John Doe(Verified)',
                      mobile: '+971552385432',
                      isVerified: true,
                      totalMonthlyTopUp: 500,
                      monthlyWallets: {},
                    );
                    userController.saveUser(user);
                  },
                  child: const Text('Verified User'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    User user = User(
                      userId: '2',
                      fullName: 'John Doe(Unverified)',
                      mobile: '+971552385432',
                      isVerified: true,
                      totalMonthlyTopUp: 1000,
                      monthlyWallets: {},
                    );
                    userController.saveUser(user);
                  },
                  child: const Text('Unverified User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
