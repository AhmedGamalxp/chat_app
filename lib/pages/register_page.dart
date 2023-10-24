import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_formfield.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'RegisterPage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff354F6A),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Icon(
                    Icons.forum,
                    color: Colors.white,
                    size: 120,
                  ),
                  const Text(
                    'My ChatApp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Pacifico'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    hintText: 'Name',
                    onChanged: (value) {
                      // email = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    hintText: 'Email',
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    hintText: 'Password',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    hintText: 'Confirm Password',
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBotton(
                    text: 'REGISTER',
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await registerUser();
                          Navigator.pushNamed(context, ChatPage.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(
                                'The account already exists for that email.');
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'alrady have an account',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          '  Login',
                          style: TextStyle(
                            color: Color(0xffD8F6F4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
