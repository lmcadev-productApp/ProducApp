import 'package:flutter/material.dart';
import 'package:frontend/models/productionStages/productionStages.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/utils/app_text_styles.dart';


class BaseScreen<T> extends StatelessWidget {
  final String titulo;
  final List<T>? items;
  final String Function(T)? tituloItem;
  final String Function(T)? subtituloItem;
  final void Function(T)? onEdit;
  final void Function(T)? onEditRole;
  final void Function(T, BuildContext context)? onDelete;
  final Widget? contenidoPersonalizado;
  final Color? colorHeader;
  final bool mostrarBack;
  final bool mostrarLogout;
  final VoidCallback? onBack;
  final VoidCallback? onLogout;
  final Widget? floatingActionButton;
  final Widget? topContent;

  const BaseScreen({
    super.key,
    required this.titulo,
    this.items,
    this.tituloItem,
    this.subtituloItem,
    this.onEdit,
    this.onEditRole,
    this.onDelete,
    this.contenidoPersonalizado,
    this.colorHeader,
    this.mostrarBack = false,
    this.mostrarLogout = false,
    this.onBack,
    this.onLogout,
    this.floatingActionButton,
    this.topContent,
  });

  void _handleEdit(BuildContext context, T item) {
    onEdit?.call(item);

  }

  void _handleDelete(BuildContext context, T item) {
    onDelete?.call(item, context);

  }

  void _handleEditRole(BuildContext context, T item) {
    onEditRole?.call(item);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: mostrarBack
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.blanco, size: 32),
          onPressed: onBack ?? () => Navigator.pop(context),
        )
            : null,
        title: Text(titulo, style: AppTextStyles.tituloHeader),
        backgroundColor: colorHeader ?? AppColors.azulIntermedio,
        iconTheme: const IconThemeData(color: AppColors.blanco),
        elevation: 0,
        actions: mostrarLogout
            ? [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: onLogout,
          ),
        ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: contenidoPersonalizado ?? Column(
          children: [
            if (topContent != null) topContent!,
            if (items == null || tituloItem == null || subtituloItem == null || onEdit == null || onDelete == null)
              const SizedBox.shrink()
            else Expanded(
              child: items!.isEmpty
                  ? const Center(child: Text('No hay elementos disponibles'))
                  : ListView.builder(
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  final item = items![index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(tituloItem!(item), style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(subtituloItem!(item)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (onEditRole != null)
                            IconButton(
                              icon: const Icon(Icons.admin_panel_settings, color: Colors.orange),
                              tooltip: 'Editar Rol',
                              onPressed: () => _handleEditRole(context, item),
                            ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: AppColors.verdeCheck),
                            tooltip: 'Editar',
                            onPressed: () => _handleEdit(context, item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Eliminar',
                            onPressed: () => _handleDelete(context, item),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
