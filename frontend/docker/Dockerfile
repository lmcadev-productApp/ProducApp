# Imagen base con Flutter y Dart 3.4.1
FROM ghcr.io/cirruslabs/flutter:3.22.0

# Variables de entorno necesarias para Android SDK
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

# Instalamos SDK de Android y herramientas necesarias
RUN yes | sdkmanager --licenses && \
    sdkmanager \
        "platform-tools" \
        "platforms;android-33" \
        "build-tools;33.0.2" \
        "ndk;26.3.11579264" \
        "cmdline-tools;latest"

# Permisos para evitar problemas de escritura
RUN chmod -R a+w $ANDROID_HOME

# Directorio de trabajo
WORKDIR /app

# Copiamos el proyecto
COPY . .

# Usamos un ARG para API_URL (inyectado desde docker-compose)
ARG API_URL

# Ejecutamos la build
RUN flutter precache --web && \
    flutter pub get && \
    flutter build web --release --dart-define=API_URL=$API_URL && \
    flutter build apk --release && \
    mkdir -p build/web/apk && \
    cp build/app/outputs/flutter-apk/app-release.apk build/web/apk/
