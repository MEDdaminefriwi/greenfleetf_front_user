import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/progress_indicator.dart';
import 'steps/email_step.dart';
import 'steps/password_step.dart';
import 'steps/name_step.dart';
import 'steps/phone_step.dart' as phone; // Alias to avoid conflict
import 'steps/dob_step.dart';
import 'steps/preference_step.dart';
import 'steps/verification_step.dart';
import 'home_screen.dart';

class SignUpFlow extends StatefulWidget {
  @override
  _SignUpFlowState createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<SignUpFlow> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final Color primaryColor = const Color(0xFF1B4242);

  // Map to store user data collected from each step
  final Map<String, dynamic> userData = {};

  void nextPage() {
    if (currentPage < 6) {
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

  // Method to send signup data to the server
  Future<void> submitSignup() async {
    final url = Uri.parse('http://192.168.213.51:8080/auth/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        // Navigate to the verification step
        nextPage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: LinearProgressIndicator(
              value: (currentPage + 1) / 7,
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
                EmailStep(
                  onNext: (email) {
                    userData['email'] = email; // Save email
                    nextPage();
                  },
                ),
                PasswordStep(
                  onNext: (password) {
                    userData['password'] = password; // Save password
                    nextPage();
                  },
                  onBack: previousPage,
                ),
                NameStep(
                  onNext: (firstName, lastName) {
                    userData['firstname'] = firstName; // Save first name
                    userData['lastname'] = lastName; // Save last name
                    nextPage();
                  },
                  onBack: previousPage,
                ),
                phone.PhoneStep(
                  onNext: (phone) {
                    userData['phoneNumber'] = phone; // Save phone number
                    nextPage();
                  },
                  onBack: previousPage,
                ),
                DobStep(
                  onNext: (dob) {
                    userData['dateOfBirth'] = dob; // Save date of birth
                    nextPage();
                  },
                  onBack: previousPage,
                ),
                PreferenceStep(
                  onSubmit: (preferences) {
                    if(preferences=="Mr."){
                    userData['gender'] = "Male";}else{userData['Gender'] = "Female";} // Save preferences
                    submitSignup(); // Send data to the server
                  },
                  onBack: previousPage,
                ),
                VerificationStep(
                  onSubmit: (code) {
                    // Handle verification code submission
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  onBack: previousPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}