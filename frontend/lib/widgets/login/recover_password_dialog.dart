import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarRecuperarContrasena(BuildContext context) {
  final emailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => DialogoGeneral(
      titulo: 'Recuperar contraseña',
      contenido: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Correo electrónico',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Ingrese su correo registrado',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Se enviará un enlace para restablecer su contraseña.',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      textoBotonOk: 'Enviar',
      onOk: () {
        //Logica
        String email = emailController.text;
        if (email.isNotEmpty) {
          print('Enviando email a: $email');
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email enviado')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ingrese su correo')),
          );
        }
      },
    ),
  );
}
