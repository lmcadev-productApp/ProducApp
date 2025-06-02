package com.poli.productApp.controller;

import com.poli.productApp.dto.UsuarioDTO;
import com.poli.productApp.model.Usuario;
import com.poli.productApp.service.UsuarioService;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    // Crear nuevo usuario
    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping
    public ResponseEntity<?> registrarUsuario(@Valid @RequestBody Usuario usuario) {
        Usuario existente = usuarioService.buscarPorCorreo(usuario.getCorreo());
        if (existente != null) {
            return ResponseEntity.badRequest().body("El correo ya está registrado.");
        }

        // Asignar rol
        usuario.setRol("USER");


        Usuario guardado = usuarioService.guardar(usuario);
        return ResponseEntity.ok("Usuario registrado con ID: " + guardado.getId());
    }


    // Listar todos los usuarios
    @GetMapping
    public List<UsuarioDTO> listarUsuarios() {
        return usuarioService.listarTodos().stream()
                .map(u -> new UsuarioDTO(u.getId(), u.getCorreo(), u.getRol(), u.getNombre(), u.getTelefono(), u.getDireccion()))
                .collect(Collectors.toList());
    }


    // Obtener un usuario por ID
    @GetMapping("/{id}")
    public ResponseEntity<?> obtenerPorId(@PathVariable Long id) {
        Usuario usuario = usuarioService.buscarPorId(id);
        if (usuario == null) {
            return ResponseEntity.notFound().build();
        }
        UsuarioDTO dto = new UsuarioDTO(
                usuario.getId(),
                usuario.getCorreo(),
                usuario.getRol(),
                usuario.getNombre(),
                usuario.getTelefono(),
                usuario.getDireccion()
        );
        return ResponseEntity.ok(dto);
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
}
