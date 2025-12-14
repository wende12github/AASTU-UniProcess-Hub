import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import 'package:uni_process_hub/features/auth/widgets/auth_header.dart';
import 'package:uni_process_hub/features/model/user_model.dart';
import 'package:uni_process_hub/firebase/firebase_service.dart';
import 'package:uni_process_hub/widgets/custom_text_field.dart';
import 'package:uni_process_hub/widgets/dropdown_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullName = TextEditingController();
  final _studentId = TextEditingController();
  final _yearOfStudy = TextEditingController();
  final _department = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  String? _enrollmentStatus;
  final _enrollmentOptions = ["Regular", "Extension", "MS", "PhD"];
  bool _agreeTerms = false;
  bool _agreePrivacy = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthHeader(
                onLoginPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                onRegisterPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                title: "Create Account",
                subtitle: "Join the digital campus community.",
                activeMode: AuthMode.register,
              ),
              SizedBox(height: 22),
              CustomTextField(
                controller: _fullName,
                label: "Full Name",
                hintText: "Enter Full Name",
                prefixIcon: Icon(Icons.person),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _studentId,
                label: "Student ID",
                hintText: "Enter e.g. ETS1111/18",
                prefixIcon: Icon(Icons.badge),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _yearOfStudy,
                label: "Year of Study",
                hintText: "e.g. 3rd Year",
                prefixIcon: Icon(Icons.history_edu),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _department,
                label: "Department",
                hintText: "e.g. Software Engineering",
                prefixIcon: Icon(Icons.school),
              ),
              const SizedBox(height: 12),
              DropdownField(
                label: "Enrollment Status",
                options: _enrollmentOptions,
                selectedValue: _enrollmentStatus,
                onChanged: (val) => setState(() => _enrollmentStatus = val),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _email,
                label: "University Email",
                hintText: "student@aastu.edu.et",
                prefixIcon: Icon(Icons.mail),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _phone,
                label: "Phone Number",
                hintText: "+251 9...",
                prefixIcon: Icon(Icons.call),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _password,
                label: "Password",
                hintText: 'Enter strong password',
                prefixIcon: Icon(Icons.lock),
                obscure: _obscurePassword,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: _confirmPassword,
                label: "Confirm Password",
                hintText: 'Enter strong password',
                prefixIcon: Icon(Icons.lock),
                obscure: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _agreeTerms,
                onChanged: (v) => setState(() => _agreeTerms = v ?? false),
                title: const Text("I agree to the Terms & Conditions"),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primary,
              ),
              CheckboxListTile(
                value: _agreePrivacy,
                onChanged: (v) => setState(() => _agreePrivacy = v ?? false),
                title: const Text("I agree to the Privacy Policy"),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppColors.primary,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_password.text != _confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }
                    if (_enrollmentStatus == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Select enrollment status"),
                        ),
                      );
                      return;
                    }

                    final user = UserModel(
                      fullName: _fullName.text,
                      studentId: _studentId.text,
                      yearOfStudy: _yearOfStudy.text,
                      department: _department.text,
                      enrollmentStatus: _enrollmentStatus!,
                      email: _email.text,
                      phone: _phone.text,
                      password: _password.text,
                    );

                    await _firebaseService.registerUser(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registration successful")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF49E619),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "SIGNUP",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
