import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_tasks/screens/auth_screen/signup_screen.dart';
import '../../mixins/snack_mixin.dart';
import 'package:flutter/material.dart';
import 'package:test_tasks/screens/auth_screen/components/msg_welcome.dart';
import 'package:test_tasks/utils/constants/app_strings.dart';
import '../../mobx/login_store/login_mobx.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../mobx/enum_state.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String logInScreen = '/login';
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with SnackMixin {
  final _formKey = GlobalKey<FormState>();
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
    _emailController.dispose();
    _passwordController.dispose();
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
                    AppStrings.instructionMsgLoginScreen,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.popAndPushNamed(
                        context, SingupScreen.singUpScreen),
                    child: Text(" Register".tr()),
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
                      ? CircularProgressIndicator() // Show loading indicator if isLoading is true
                      : Text(
                          'Log in'.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      authInfo.setEmail(_emailController.text);
                      authInfo.setPassword(_passwordController.text);
                      bool canLogin = await authInfo.login();
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
        leading: const Icon(Icons.turn_left),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            MsgWelcome(
              messageWelcome: "${AppStrings.messageWelcomeloginScreen}",
              headlineWelcome: "${AppStrings.headlineWelcomeLoginScreen}",
            ),
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
                      labelText: 'Phone,Username or Email'.tr(),
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
