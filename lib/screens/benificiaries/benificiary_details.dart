import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:assessment_sep_2024/screens/benificiaries/benificiary_service.dart';
import 'package:assessment_sep_2024/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeneficiaryDetails extends StatelessWidget {
  final Beneficiary beneficiary;
  final BeneficiaryService beneficiaryService = Get.put(BeneficiaryService());

  BeneficiaryDetails({super.key, required this.beneficiary});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            capitalizeEachWord(beneficiary.nickname),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Full Name: ${beneficiary.fullname}'),
          const SizedBox(height: 8),
          Text('Phone: ${beneficiary.phoneNumber}'),
          const SizedBox(height: 16),
          const Divider(),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 260),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                beneficiaryService.deleteBeneficiary(context, beneficiary);
              },
              child: const Text('Delete'),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
