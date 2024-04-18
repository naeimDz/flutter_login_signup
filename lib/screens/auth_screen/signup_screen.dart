import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_tasks/screens/auth_screen/login_screen.dart';
import '../../mixins/snack_mixin.dart';
import 'package:flutter/material.dart';
import 'package:test_tasks/screens/auth_screen/components/msg_welcome.dart';
import 'package:test_tasks/utils/constants/app_strings.dart';
import '../../mobx/login_store/login_mobx.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../mobx/enum_state.dart';
import '../home_screen.dart';

class SingupScreen extends StatefulWidget {
  static const String singUpScreen = '/singup';
  const SingupScreen({super.key});
  @override
  SingupScreenState createState() => SingupScreenState();
}

class SingupScreenState extends State<SingupScreen> with SnackMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscureText = true;
  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authInfo = Provider.of<LoginBase>(context);
    return Scaffold(
      bottomNavigationBar: Observer(
        builder: (context) {
          return Wrap(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.instructionMsgSingupScreen,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(
                        context, LoginScreen.logInScreen),
                    child: Text(" Login".tr()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: authInfo.state == LoadingState.loading
                      ? const CircularProgressIndicator() // Show loading indicator if isLoading is true
                      : Text(
                          'Register'.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      authInfo.setUsername(_usernameController.text.trim());
                      authInfo.setPassword(_passwordController.text);
                      authInfo.setEmail(_emailController.text.trim());
                      bool canLogin = await authInfo.singup();
                      if (canLogin && mounted) {
                        showSuccess(
                            context, AppStrings.loginSuccessMessage.tr());
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.homeScreen);
                      } else {
                        showError(context, AppStrings.loginErrorMessage.tr());
                      }
                    }
                  },
                ),
              ),
            ),
          ]);
        },
      ),
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Wrap(
          spacing: 10,
          children: [
            MsgWelcome(
                messageWelcome: AppStrings.messageWelcomeSingupScreen,
                headlineWelcome: AppStrings.headlineWelcomeSingupScreen),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Email'.tr();
                      }
                      return null; // here add other validator rules
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Usernamel'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => toggleObscureText(),
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      labelText: 'Password'.tr(),
                    ),
                    obscureText: obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password'.tr();
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
