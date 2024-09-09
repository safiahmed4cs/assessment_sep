import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:assessment_sep_2024/screens/benificiaries/benificiary_details.dart';
import 'package:assessment_sep_2024/screens/benificiaries/benificiary_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargeScreen extends StatelessWidget {
  final BeneficiaryService beneficiaryService;

  const RechargeScreen({super.key, required this.beneficiaryService});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int totalCount = beneficiaryService.beneficiaries.length;
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
          final beneficiary = beneficiaryService.beneficiaries[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.42,
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
                  padding: const EdgeInsets.all(16),
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
                          if (beneficiary.isVerified)
                            const Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                          if (!beneficiary.isVerified)
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                beneficiaryService.deleteBeneficiary(
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
                      const SizedBox(height: 8),
                      ElevatedButton(
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
