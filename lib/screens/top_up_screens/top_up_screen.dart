import 'package:assessment_sep_2024/controllers/topup_controller.dart';
import 'package:assessment_sep_2024/models/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpScreen extends StatelessWidget {
  TopUpScreen({super.key});

  final TopUpController topUpController = Get.put(TopUpController());

  @override
  Widget build(BuildContext context) {
    final beneficiary =
        ModalRoute.of(context)!.settings.arguments as Beneficiary;
    topUpController.selectedAmount.value = 0;

    return Scaffold(
      appBar: AppBar(title: Text('Top Up ${beneficiary.fullname}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Top Up', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Selected Amount',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: topUpController.selectedAmount.value == 0
                      ? ''
                      : 'AED ${topUpController.selectedAmount.value}',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              const Text('Select Amount', style: TextStyle(fontSize: 16)),
              Wrap(
                spacing: 8.0,
                children: topUpController.topUpOptions.map((amount) {
                  return ChoiceChip(
                    label: Text('AED $amount'),
                    selected: topUpController.selectedAmount.value == amount,
                    onSelected: (selected) {
                      if (selected) {
                        topUpController.selectAmount(amount);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              if (topUpController.selectedAmount.value > 0) ...[
                const Divider(height: 2),
                const SizedBox(height: 16),
              ],
              if (topUpController.selectedAmount.value > 0) ...[
                Column(
                  children: [
                    _richText(
                      label: 'Selected Amount:',
                      value: 'AED ${topUpController.selectedAmount}',
                    ),
                    _richText(
                      label: 'Charge:',
                      value: 'AED ${topUpController.charge}',
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      height: 2,
                    ),
                    const SizedBox(height: 8),
                    _richText(
                      label: 'Subtotal:',
                      value: 'AED ${topUpController.totalAmount}',
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  bool res = await topUpController.topUp(
                    beneficiary,
                    topUpController.selectedAmount.value,
                  );
                  if (res) Get.back();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text('Top Up ${topUpController.totalAmount}'),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _richText({required String label, required String value}) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Container(
              alignment: Alignment.centerRight,
              width: 140, // Set a fixed width for the label
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
          const TextSpan(text: '  '),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
