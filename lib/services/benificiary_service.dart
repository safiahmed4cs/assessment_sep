import 'package:assessment_sep_2024/models/benificiary.dart';

class BeneficiaryService {
  final List<Beneficiary> _beneficiaries = [];

  List<Beneficiary> get beneficiaries => _beneficiaries;

  void addBeneficiary(Beneficiary beneficiary) {
    if (_beneficiaries.length < 5) {
      _beneficiaries.add(beneficiary);
    }
  }

  void removeBeneficiary(Beneficiary beneficiary) {
    _beneficiaries.remove(beneficiary);
  }
}
