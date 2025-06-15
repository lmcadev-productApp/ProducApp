import 'dart:io';

const String _envBaseUrl = String.fromEnvironment('API_URL');

// El código seleccionado define una variable baseUrl que se utiliza para determinar
// la URL base de la API en función del entorno de ejecución y la plataforma.
// Este enfoque permite que la aplicación se adapte automáticamente según el
// entorno en el que se ejecute, como Android o un sistema operativo de escritorio.
final String baseUrl = _envBaseUrl.isNotEmpty
    ? _envBaseUrl
    : (Platform.isAndroid
    ? 'http://productapp.lmcadev.com:8081/api'
    : 'http://productapp.lmcadev.com:8081/api');
