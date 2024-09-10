import 'package:assessment_sep_2024/controllers/benificiary_controller.dart';
import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:assessment_sep_2024/screens/benificiaries/benificiary_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargeScreen extends StatelessWidget {
  final BeneficiaryController beneficiaryController;

  const RechargeScreen({super.key, required this.beneficiaryController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int totalCount = beneficiaryController.beneficiaries.length;
      if (totalCount == 0) {
        return const Center(
          child: Text(
            'No beneficiaries found. Please add a beneficiary.',
            style: TextStyle(fontSize: 14),
          ),
        );
      }
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: totalCount,
        itemBuilder: (context, index) {
          final beneficiary = beneficiaryController.beneficiaries[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.40,
            margin: EdgeInsets.only(
              left: index == 0 ? 8 : 4,
              right: index == totalCount - 1 ? 8 : 4,
            ),
            child: InkWell(
              onTap: () => _showBeneficiaryDetails(context, beneficiary),
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
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              beneficiaryController.deleteBeneficiary(
                                context,
                                beneficiary,
                              );
                            },
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
            ),
          );
        },
      );
    });
  }

  void _showBeneficiaryDetails(BuildContext context, Beneficiary beneficiary) {
    showDialog(
      context: context,
      builder: (context) {
        return BeneficiaryDetails(beneficiary: beneficiary);
      },
    );
  }
}
