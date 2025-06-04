import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:frontend/widgets/dialogs/loading_general.dart';

void main() {
  runApp(ProducApp());
}

class ProducApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: SharedPreferencesHelper.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: LoadingDialog(),
            );
          }

          // Si hay token mostrar la HomePage con rol quemado "admin"
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return HomePage(userRole: 'admin');
          }

          // Si no hay token ir a la LoginPage
          return const LoginPage();
        },
      ),
    );
  }
}
