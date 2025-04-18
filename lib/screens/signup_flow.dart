import 'package:flutter/material.dart';
import '../widgets/progress_indicator.dart';
import 'steps/email_step.dart';
import 'steps/name_step.dart';
import 'steps/phone_step.dart';
import 'steps/dob_step.dart';
import 'steps/preference_step.dart';
import 'package:flutter_course/screens/home_screen.dart';

class SignUpFlow extends StatefulWidget {
  @override
  _SignUpFlowState createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<SignUpFlow> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final Color primaryColor = const Color(0xFF1B4242);

  void nextPage() {
    if (currentPage < 4) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Custom progress indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: LinearProgressIndicator(
              value: (currentPage + 1) / 5,
              backgroundColor: primaryColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              minHeight: 5,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                EmailStep(onNext: nextPage),
                NameStep(onNext: nextPage, onBack: previousPage),
                PhoneStep(onNext: nextPage, onBack: previousPage),
                DobStep(onNext: nextPage, onBack: previousPage),
                PreferenceStep(
                  onBack: previousPage,
                  onSubmit: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
