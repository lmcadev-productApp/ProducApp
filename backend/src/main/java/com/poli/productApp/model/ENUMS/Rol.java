package com.poli.productApp.model.ENUMS;

public enum Rol {
    ADMINISTRADOR("Administrador"),
    SUPERVISOR("Supervisor"),
    OPERARIO("Operario"),
    CLIENTE("Cliente");

    private final String nombre;

    Rol(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }
}
