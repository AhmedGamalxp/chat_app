import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_formfield.dart';

class LoginPage extends StatefulWidget {
  static String id = 'LoginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;
  bool isLoading = false;
  bool obscureTextValue = true;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xff354F6A),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
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
                      'LOGIN',
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
                  suffixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  hintText: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureTextValue
                            ? obscureTextValue = false
                            : obscureTextValue = true;
                      });
                    },
                    icon: obscureTextValue
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.white,
                          ),
                  ),
                  obscureText: obscureTextValue,
                  onChanged: (value) {
                    password = value;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBotton(
                  text: 'LOGIN',
                  ontap: () async {
                    if (/*formKey.currentState!.validate()*/ true) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        print(e);
                        showSnackBar('there was an error');
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
                      'don\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'RegisterPage');
                      },
                      child: const Text(
                        '  Register',
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
    );
  }

  void showSnackBar(String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }

  Future<void> loginUser() async {
 await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
