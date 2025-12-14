import 'package:flutter/material.dart';
import 'package:uni_process_hub/features/auth/widgets/auth_header.dart';
import 'package:uni_process_hub/firebase/firebase_service.dart';
import 'package:uni_process_hub/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _studentId = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _obscurePassword = true;

  final _firebaseService = FirebaseService();
  bool _loading = false;

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
              // Header
              AuthHeader(
                onLoginPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                onRegisterPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                title: 'UniProcess Hub',
                subtitle: 'Manage queues, forms, and appointment in one place',
                activeMode: AuthMode.login,
                logoUrl: "assets/logos/g_logo.png",
              ),
              SizedBox(height: 22),
              CustomTextField(
                controller: _studentId,
                label: "Student ID",
                hintText: "Enter e.g. ETS1111/18",
                prefixIcon: Icon(Icons.badge),
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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF49E619),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account?",
                    style: TextStyle(fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// HAVING TROUBLE SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Having trouble?",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/support');
                    },
                    child: const Text(
                      "Contact Support",
                      style: TextStyle(
                        color: Color.fromARGB(255, 240, 65, 12),
                        fontWeight: FontWeight.bold,
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

  Future<void> _login() async {
    if (_studentId.text.isEmpty ||
        _email.text.isEmpty ||
        _password.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    setState(() => _loading = true);

    try {
      await _firebaseService.login(
        email: _email.text.trim(),
        password: _password.text,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login successful")));

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _loading = false);
    }
  }
}
