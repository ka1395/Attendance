import 'package:attendance/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return ' يرجي كتابه البريد الإلكتروني بشكل صحيح  ';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    return null;
  }

  GlobalKey<FormState> formkey = GlobalKey();

  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).width * .6,
                      width: MediaQuery.sizeOf(context).width * .9,
                      child: Image.asset('assets/images/splash.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    decoration: const InputDecoration(
                      labelText: 'عنوان البريد الالكترونى',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: showpassword,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      labelText: 'كلمه المرور',
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        icon: showpassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(
                                Icons.visibility,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      elevation: 5,
                      color: AppColors.primaryColorLight,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: MaterialButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            var router = MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const HomeScreens(),
                            );
                            //can back for previos page
                            Navigator.of(context).pushReplacement(router);
                          }
                        },
                        child: Text('تسجيل دخول ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.colorWhite)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
