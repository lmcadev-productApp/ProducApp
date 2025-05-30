package com.poli.productApp.util;

import java.util.UUID;

public class UUIDGenerator {
    public static String generar() {
        return UUID.randomUUID().toString();
    }
}
