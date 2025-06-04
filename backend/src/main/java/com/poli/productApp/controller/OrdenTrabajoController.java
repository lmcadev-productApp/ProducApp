package com.poli.productApp.controller;

import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.service.OrdenTrabajoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ordenes")
public class OrdenTrabajoController {

    @Autowired
    private OrdenTrabajoService service;

    @PostMapping
    public ResponseEntity<OrdenTrabajo> crearOrden(@RequestBody OrdenTrabajo orden) {
        return ResponseEntity.ok(service.guardar(orden));
    }

    @GetMapping
    public ResponseEntity<List<OrdenTrabajo>> listarOrdenes() {
        return ResponseEntity.ok(service.listar());
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrdenTrabajo> obtenerOrden(@PathVariable Long id) {
        return service.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrdenTrabajo> actualizarOrden(@PathVariable Long id, @RequestBody OrdenTrabajo orden) {
        try {
            return ResponseEntity.ok(service.actualizar(id, orden));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarOrden(@PathVariable Long id) {
        service.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
