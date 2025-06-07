package com.poli.productApp.service;

import com.poli.productApp.model.ENUMS.Rol;
import com.poli.productApp.model.usuario.Usuario;
import com.poli.productApp.repository.UsuarioRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public Usuario guardar(Usuario usuario) {
        // Asignar rol por defecto si no viene asignado
        if (usuario.getRol() == null) {
            usuario.setRol(Rol.OPERARIO);
        }

        // Encriptar la contraseña antes de guardar
        String contrasenaEncriptada = passwordEncoder.encode(usuario.getContrasena());
        usuario.setContrasena(contrasenaEncriptada);

        return usuarioRepository.save(usuario);
    }


    public Usuario buscarPorCorreo(String correo) {
        return usuarioRepository.findByCorreo(correo).orElse(null);
    }

    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    public Usuario buscarPorId(Long id) {
        return usuarioRepository.findById(id).orElse(null);
    }

    public boolean eliminar(Long id) {
        if (usuarioRepository.existsById(id)) {
            usuarioRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public Usuario actualizar(Usuario usuario) {
        if (usuarioRepository.existsById(usuario.getId())) {
            // Encriptar la contraseña antes de actualizar
            String contrasenaEncriptada = passwordEncoder.encode(usuario.getContrasena());
            usuario.setContrasena(contrasenaEncriptada);
            return usuarioRepository.save(usuario);
        }
        return null;
    }



}
