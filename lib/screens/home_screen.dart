import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:test_tasks/mobx/product_store/product_mobx.dart';
import 'package:test_tasks/screens/auth_screen/login_screen.dart';
import '../mobx/login_store/login_mobx.dart';

class HomeScreen extends StatelessWidget {
  static const String homeScreen = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authInfo = Provider.of<LoginBase>(context);
    final product = Provider.of<ProductStore>(context);
    product.fetchProducts("products");
    print("${"home_msg".tr()} ${authInfo.username}!");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              authInfo.signOut();
              Navigator.popAndPushNamed(context, LoginScreen.logInScreen);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Text("${"home_msg".tr()} ${authInfo.username}!"),
    );
  }
}
