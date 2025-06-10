package com.poli.productApp.controller;


import com.poli.productApp.model.ENUMS.Rol;
import com.poli.productApp.model.usuario.Usuario;
import com.poli.productApp.service.UsuarioService;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    // Crear nuevo usuario

    @PostMapping
    public ResponseEntity<?> registrarUsuario(@Valid @RequestBody Usuario usuario) {
        Usuario existente = usuarioService.buscarPorCorreo(usuario.getCorreo());
        if (existente != null) {
            return ResponseEntity.badRequest().body("El correo ya está registrado.");
        }

        // Asignar rol
        usuario.setRol(Rol.OPERARIO);


        Usuario guardado = usuarioService.guardar(usuario);
        return ResponseEntity.ok("Usuario registrado con ID: " + guardado.getId());
    }






    // Eliminar usuario
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarUsuario(@PathVariable Long id) {
        if (usuarioService.eliminar(id)) {
            return ResponseEntity.ok("Usuario eliminado");
        } else {
            return ResponseEntity.status(404).body("Usuario no encontrado");
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> obtenerUsuarioPorId(@PathVariable Long id) {
        Usuario usuario = usuarioService.buscarPorId(id);
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        } else {
            return ResponseEntity.status(404).body("Usuario no encontrado");
        }
    }

    @GetMapping("/")
    public ResponseEntity<?> obtenerTodosLosUsuarios() {
        return ResponseEntity.ok(usuarioService.listarTodos());
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> actualizarUsuario(@PathVariable Long id, @Valid @RequestBody Usuario usuario) {
        usuario.setId(id);
        Usuario actualizado = usuarioService.actualizar(usuario);
        if (actualizado != null) {
            return ResponseEntity.ok("Usuario actualizado con ID: " + actualizado.getId());
        } else {
            return ResponseEntity.status(404).body("Usuario no encontrado");
        }
    }


    @GetMapping("/{correo}")
    public ResponseEntity<?> obtenerUsuarioPorCorreo(@PathVariable String correo) {
        Usuario usuario = usuarioService.buscarPorCorreo(correo);
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        } else {
            return ResponseEntity.status(404).body("Usuario no encontrado");
        }
    }
}
