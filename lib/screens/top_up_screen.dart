import 'package:assessment_sep_2024/controllers/topup_controller.dart';
import 'package:assessment_sep_2024/models/benificiary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpScreen extends StatelessWidget {
  TopUpScreen({super.key});

  final TopUpController topUpController = Get.put(TopUpController());

  @override
  Widget build(BuildContext context) {
    final beneficiary =
        ModalRoute.of(context)!.settings.arguments as Beneficiary;

    return Scaffold(
      appBar: AppBar(title: Text('Top Up ${beneficiary.fullname}')),
      body: ListView.builder(
        itemCount: topUpController.topUpOptions.length,
        itemBuilder: (context, index) {
          final option = topUpController.topUpOptions[index];
          return ListTile(
            title: Text('AED ${option.amount}'),
            onTap: () {
              if (topUpController.topUp(beneficiary, option.amount)) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Top Up Successful')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Top Up Failed')));
              }
            },
          );
        },
      ),
    );
  }
}
