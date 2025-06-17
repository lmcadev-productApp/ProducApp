import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

const String _envBaseUrl = String.fromEnvironment('API_URL');

final String baseUrl =
_envBaseUrl.isNotEmpty ? _envBaseUrl : _getDefaultBaseUrl();

String _getDefaultBaseUrl() {
  if (kIsWeb) {
    // Código para Flutter Web
    return 'http://productapp.lmcadev.com:8081/api';
  } else {
    if (Platform.isAndroid) {
      return 'http://productapp.lmcadev.com:8081/api'; // Para emulador Android
    } else {
      return 'http://productapp.lmcadev.com:8081/api';
    }
  }
}
