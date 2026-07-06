import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maruthimedical/widgets/button.dart';
import 'package:maruthimedical/widgets/text_field.dart';
import 'package:maruthimedical/services/login_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usrname = TextEditingController();
  TextEditingController phno = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Ramprasad ",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              TextSpan(
                text: "Nayak",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D6FB8),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Text(
                "Create your Account",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              MyTextField(
                hintText: "Choose a Username or Email",
                height: 56,
                width: 380,
                prefixicon: Icons.person_outline,
                controller: usrname,
                eyebutton: false,
                hideText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Phone Number",
                height: 56,
                width: 380,
                prefixicon: Icons.phone_outlined,
                controller: phno,
                eyebutton: false,
                hideText: false,
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Create Strong Password",
                height: 56,
                width: 380,
                prefixicon: Icons.lock_outline,
                controller: password,
                eyebutton: true,
                hideText: true,
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1D6FB8),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 40),
              Button(
                height: 56,
                width: 380,
                text: "Register",
                onpressed: ()=>register(context,usrname,phno,password),
              ),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    TextSpan(
                      text: "Login Now",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1D6FB8),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
