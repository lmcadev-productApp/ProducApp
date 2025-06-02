package com.poli.productApp.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UsuarioDTO {
    private Long id;
    private String correo;
    private String rol;
    private String nombre;
    private String telefono;
    private String direccion;
}
