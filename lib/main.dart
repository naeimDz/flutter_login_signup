import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tasks/mobx/product_store/product_mobx.dart';
import 'package:test_tasks/screens/auth_screen/login_screen.dart';
import 'package:test_tasks/screens/home_screen.dart';
import 'package:test_tasks/utils/app_theme.dart';
import 'package:test_tasks/utils/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'data/firestore_source.dart';
import 'mobx/login_store/login_mobx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale('en'),
    child: MultiProvider(providers: [
      Provider<LoginBase>(create: (_) => LoginBase()),
      Provider<ProductStore>(create: (_) => ProductStore()),
    ], builder: (context, child) => const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'test',
      theme: AppTheme.darkTheme,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? HomeScreen.homeScreen
          : LoginScreen.logInScreen,
    );
  }
}
