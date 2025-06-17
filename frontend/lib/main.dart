import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/widgets/dialogs/loading_general.dart';

void main() {
  runApp(ProducApp());
}

class ProducApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'), // Idioma por defecto: español
      supportedLocales: const [Locale('es')], // Locales soportados
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: FutureBuilder<String?>(
        future: SharedPreferencesHelper.getToken(),
        builder: (context, tokenSnapshot) {
          if (tokenSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: LoadingDialog(),
            );
          }

          if (!tokenSnapshot.hasData || tokenSnapshot.data!.isEmpty) {
            return const LoginPage();
          }

          return FutureBuilder<String?>(
            future: SharedPreferencesHelper.getRol(),
            builder: (context, rolSnapshot) {
              if (rolSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: LoadingDialog(),
                );
              }

              final rawRole = rolSnapshot.data;
              final validRoles = [
                'ADMINISTRADOR',
                'SUPERVISOR',
                'OPERARIO',
                'USUARIO'
              ];
              final normalizedRole = rawRole?.toUpperCase();

              if (normalizedRole == null ||
                  !validRoles.contains(normalizedRole)) {
                return const LoginPage();
              }

              return HomePage(userRole: normalizedRole);
            },
          );
        },
      ),
    );
  }
}
