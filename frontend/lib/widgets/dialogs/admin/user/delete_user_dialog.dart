import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart'; // Ajusta el import según tu proyecto

void alPresionarEliminar(
    BuildContext context, User user, VoidCallback refrescarLista) async {
  final idAEliminar = await mostrarDialogoEliminar(context, user);
  if (idAEliminar != null) {
    try {
      await UserService().deleteUser(idAEliminar);
      print('Usuario eliminado: $idAEliminar');
      Navigator.of(context).pop();
      refrescarLista(); // refresca la lista después de eliminar
    } catch (e) {
      String mensajeError = 'Error al eliminar usuario.';
      if (e.toString().contains('409') ||
          e.toString().toLowerCase().contains('foreign key')) {
        mensajeError =
            'No se puede eliminar el usuario porque tiene registros relacionados.';
      }
      await DialogoHelper.mostrarError(
        context,
        titulo:
            'Error No se puede eliminar el usuario porque tiene registros relacionados.',
        mensaje: mensajeError,
      );
    }
  }
}

Future<int?> mostrarDialogoEliminar(BuildContext context, User user) async {
  final resultado = await DialogoHelper.mostrarConfirmacion(
    context,
    titulo: 'Eliminar usuario',
    mensaje: '¿Estás seguro de eliminar el usuario "${user.nombre}"?',
    textoOk: 'Eliminar',
    textoCancelar: 'Cancelar',
    color: Colors.red,
  );

  if (resultado == true) {
    return user.id;
  } else {
    return null;
  }
}
