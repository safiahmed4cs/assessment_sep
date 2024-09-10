import 'package:assessment_sep_2024/controllers/benificiary_controller.dart';
import 'package:assessment_sep_2024/controllers/user_controller.dart';
import 'package:assessment_sep_2024/models/user.dart';
import 'package:assessment_sep_2024/screens/benificiaries/beneficiary_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assessment_sep_2024/controllers/segment_controller.dart';
import 'package:assessment_sep_2024/screens/benificiaries/partials/recharge_screen.dart';
import 'package:assessment_sep_2024/screens/benificiaries/partials/history_screen.dart';
import 'package:assessment_sep_2024/widgets/segment_button.dart';

class BeneficiaryListScreen extends StatelessWidget {
  final SegmentController segmentController = Get.put(SegmentController());
  final UserController userController = Get.find<UserController>();
  final BeneficiaryController beneficiaryController =
      Get.find<BeneficiaryController>();

  User get user => userController.currentUser.value!;
  String get month => DateTime.now().month.toString();

  BeneficiaryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load beneficiaries from SharedPreferences
    beneficiaryController.loadBeneficiaries();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Recharge"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddBeneficiaryForm(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  final user = userController.currentUser.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user != null
                            ? 'Welcome, ${user.fullName}'
                            : 'Mobile Recharge',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildUserBalanceSection(),
                    ],
                  );
                }),

                // User Logout
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    userController.logout();
                  },
                ),
              ],
            ),
          ),
          // Segment Control
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SegmentButton(text: 'Recharge', index: 0),
                SegmentButton(text: 'History', index: 1),
              ],
            ),
          ),
          // Segment Screens
          SizedBox(
            height: 200,
            child: Obx(() {
              return segmentController.selectedSegment.value == 0
                  ? RechargeScreen(beneficiaryController: beneficiaryController)
                  : const HistoryScreen();
            }),
          ),
          // Beneficiary List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserBalanceSection() {
    return Obx(() {
      final user = userController.currentUser.value!;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'User Balance: AED ${user.getBalanceAmountInMonth(month)}',
        ),
      );
    });
  }

  void _showAddBeneficiaryForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    if (beneficiaryController.beneficiaries.length >= 5) {
      Get.snackbar(
        'Error',
        'You can only add up to 5 beneficiaries.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Beneficiary',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    BeneficiaryForm(
                      formKey: formKey,
                      onSave: (fullname, phoneNumber, nickname) async {
                        await beneficiaryController.addBeneficiary(
                          fullname: fullname,
                          nickname: nickname,
                          phoneNumber: phoneNumber,
                        );
                        Navigator.of(context).pop();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
