import 'package:assessment_sep_2024/controllers/topup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  TopUpController get topUpController => Get.find<TopUpController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int totalCount = topUpController.beneficiaries.length;
      if (totalCount == 0) {
        return const Center(
          child: Text(
            'No beneficiaries found. Please add a beneficiary.',
            style: TextStyle(fontSize: 14),
          ),
        );
      }
      return ListView.builder(
        itemCount: totalCount,
        itemBuilder: (context, index) {
          final beneficiary = topUpController.beneficiaries[index];
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: index == 0 ? 8 : 4,
              right: index == totalCount - 1 ? 8 : 4,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            beneficiary.nickname,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      beneficiary.fullname,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      beneficiary.phoneNumber,
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        minimumSize: const Size(double.infinity, 30),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/topup',
                            arguments: beneficiary);
                      },
                      child: const Text('Recharge Now'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
