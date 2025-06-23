import 'package:flutter/material.dart';
import 'package:frontend/helper/input_form_field.dart' show inputFormField;
import 'package:frontend/models/users/user.dart';
import 'package:frontend/models/specialty/specialty.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/services/specialties/specialty_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarUsuario(
  BuildContext context,
  User usuario,
  VoidCallback onUsuarioActualizado,
) {
  final nombreCtrl = TextEditingController(text: usuario.nombre);
  final correoCtrl = TextEditingController(text: usuario.correo);
  final passwordCtrl = TextEditingController(text: usuario.contrasena);
  final telefonoCtrl = TextEditingController(text: usuario.telefono);
  final direccionCtrl = TextEditingController(text: usuario.direccion);

  bool isLoading = false;
  bool passwordVis = false;
  bool botonActivo = false;

  Specialty? especialidadSeleccionada = usuario.especialidad;
  List<Specialty> especialidades = [];
  bool cargandoEspecialidades = true;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          void _validarCampos() {
            final camposTextoModificados =
                nombreCtrl.text.trim() != usuario.nombre ||
                    correoCtrl.text.trim() != usuario.correo ||
                    passwordCtrl.text.trim() != usuario.contrasena;

            final especialidadModificada =
                especialidadSeleccionada?.id != usuario.especialidad?.id;

            setState(() {
              botonActivo = camposTextoModificados || especialidadModificada;
            });
          }

          void _cargarEspecialidades() async {
            try {
              final data = await SpecialtyService().getAllSpecialties();
              setState(() {
                especialidades = data;
                cargandoEspecialidades = false;
              });
            } catch (e) {
              print('Error cargando especialidades: $e');
              setState(() => cargandoEspecialidades = false);
            }
          }

          if (cargandoEspecialidades && especialidades.isEmpty) {
            _cargarEspecialidades();
          }

          return WillPopScope(
            onWillPop: () async => !isLoading,
            child: DialogoGeneral(
              titulo: 'Editar usuario',
              contenido: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputFormField(
                      label: 'Nombre',
                      hint: 'Ingrese el nombre',
                      controller: nombreCtrl,
                      onChanged: (_) => _validarCampos(),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Correo',
                      hint: 'Ingrese el correo',
                      controller: correoCtrl,
                      tipoTeclado: TextInputType.emailAddress,
                      onChanged: (_) => _validarCampos(),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Contraseña',
                      hint: 'Ingrese la contraseña',
                      controller: passwordCtrl,
                      isPassword: true,
                      passwordVisible: passwordVis,
                      onTogglePassword: () {
                        setState(() => passwordVis = !passwordVis);
                      },
                      onChanged: (_) => _validarCampos(),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Teléfono',
                      hint: 'Ingrese el teléfono',
                      controller: telefonoCtrl,
                      tipoTeclado: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Dirección',
                      hint: 'Ingrese la dirección',
                      controller: direccionCtrl,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Especialidad',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    cargandoEspecialidades
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<Specialty>(
                            isExpanded: true,
                            value: especialidadSeleccionada,
                            dropdownColor: AppColors.azulClaroFondo,
                            menuMaxHeight: 250,
                            itemHeight: 48,
                            borderRadius: BorderRadius.circular(8),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[50],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                    color: AppColors.azulIntermedio,
                                    width: 1.4),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
                            ),
                            items: especialidades
                                .map((especialidad) => DropdownMenuItem(
                                      value: especialidad,
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 150),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: especialidad ==
                                                    especialidadSeleccionada
                                                ? AppColors.azulIntermedio
                                                    .withOpacity(.15)
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            '${especialidad.id} - ${especialidad.nombre}',
                                            style: TextStyle(
                                              fontWeight: especialidad ==
                                                      especialidadSeleccionada
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                            selectedItemBuilder: (ctx) => especialidades
                                .map((e) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${e.id} - ${e.nombre}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (valor) {
                              setState(() {
                                especialidadSeleccionada = valor;
                              });
                              _validarCampos();
                            },
                          ),
                  ],
                ),
              ),
              botonOkPersonalizado: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: Wrap(
                        spacing: 14,
                        children: [
                          PrimaryButton(
                            text: 'Cancelar',
                            width: 135,
                            height: 48,
                            fontSize: 16,
                            backgroundColor: AppColors.azulIntermedio,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          PrimaryButton(
                            text: 'Guardar',
                            width: 135,
                            height: 48,
                            fontSize: 16,
                            isEnabled: botonActivo,
                            backgroundColor: botonActivo
                                ? AppColors.azulIntermedio
                                : AppColors.grisTextoSecundario,
                            onPressed: () {
                              if (!botonActivo || isLoading) return;

                              () async {
                                try {
                                  setState(() => isLoading = true);

                                  final usuarioActualizado = usuario.copyWith(
                                    nombre: nombreCtrl.text.trim(),
                                    correo: correoCtrl.text.trim(),
                                    contrasena: passwordCtrl.text.trim(),
                                    telefono: telefonoCtrl.text.trim(),
                                    direccion: direccionCtrl.text.trim(),
                                    especialidad: especialidadSeleccionada,
                                  );

                                  await UserService().updateUser(
                                      usuario.id!, usuarioActualizado);

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    onUsuarioActualizado();
                                  }
                                } catch (e) {
                                  if (context.mounted) Navigator.pop(context);
                                  debugPrint('Error al actualizar usuario: $e');
                                } finally {
                                  if (context.mounted) {
                                    setState(() => isLoading = false);
                                  }
                                }
                              }();
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      );
    },
  ).then((_) {
    Future.delayed(const Duration(milliseconds: 300), () {
      nombreCtrl.dispose();
      correoCtrl.dispose();
      passwordCtrl.dispose();
      telefonoCtrl.dispose();
      direccionCtrl.dispose();
    });
  });
}
