import 'package:assessment_sep_2024/bindings/app_bindings.dart';
import 'package:assessment_sep_2024/screens/benificiaries/beneficiary_list_screen.dart';
import 'package:assessment_sep_2024/screens/home_screen.dart';
import 'package:assessment_sep_2024/screens/top_up_screens/top_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E Assessment App',
      initialBinding: AppBindings(),
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/benificiaries': (context) => BeneficiaryListScreen(),
        '/topup': (context) => TopUpScreen(),
      },
    );
  }
}
