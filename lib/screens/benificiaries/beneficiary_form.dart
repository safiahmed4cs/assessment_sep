import 'package:assessment_sep_2024/controllers/benificiary_controller.dart';
import 'package:assessment_sep_2024/screens/benificiaries/benificiary_service.dart';
import 'package:assessment_sep_2024/utils/capitalize_words_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BeneficiaryForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Function(String, String, String) onSave;

  BeneficiaryForm({
    super.key,
    required this.formKey,
    required this.onSave,
  });

  final BeneficiaryController beneficiaryController =
      Get.put(BeneficiaryController());

  final BeneficiaryService beneficiaryService = Get.put(BeneficiaryService());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Full Name'),
            autocorrect: false,
            validator: beneficiaryController.validateFullname,
            onSaved: beneficiaryController.saveFullName,
            inputFormatters: [
              LengthLimitingTextInputFormatter(100),
              CapitalizeWordsInputFormatter(),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Nickname'),
            autocorrect: false,
            validator: beneficiaryController.validateNickname,
            onSaved: beneficiaryController.saveNickname,
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
              CapitalizeWordsInputFormatter(),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Mobile Number'),
            validator: beneficiaryController.validatePhoneNumber,
            onSaved: beneficiaryController.savePhoneNumber,
            autocorrect: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\+971\d{0,9}')),
              LengthLimitingTextInputFormatter(13),
            ],
            keyboardType: TextInputType.number,
            initialValue: '+971',
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  final fullname = beneficiaryController.fullname.value;
                  final nickname = beneficiaryController.nickname.value;
                  final phoneNumber = beneficiaryController.phoneNumber.value;
                  if (fullname != "" && phoneNumber != "") {
                    await beneficiaryService.addBeneficiary(
                      fullname: fullname,
                      phoneNumber: phoneNumber,
                      nickname: nickname,
                    );
                    Navigator.of(context).pop();
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please enter a name and mobile number',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
