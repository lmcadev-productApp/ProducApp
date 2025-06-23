package com.poli.productApp.model.ENUMS;

public enum Estado {
    PENDIENTE("Pediente"),
    ASIGNADA("Asignada"),
    EN_PROCESO("En proceso"),
    COMPLETADO("Completado"),
    CANCELADO("Cancelado"),
    RECHAZADO("Rechazado"),
    PAUSADO("Pausado");

    private final String nombre;

    Estado(String nombre) {
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }
}
