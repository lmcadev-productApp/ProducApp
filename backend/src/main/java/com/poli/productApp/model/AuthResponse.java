package com.poli.productApp.model;

public class AuthResponse {
    private String token;
    private String rol;
    private String id;
    public AuthResponse(String token, String rol, String id) {
        this.token = token;
        this.rol = rol;
        this.id = id;
    }
    public String getToken() {
        return token;
    }

    public String getRol() {
        return rol;
    }

    public String getId() {
        return id;
    }
}