package com.poli.productApp.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.poli.productApp.model.etapa.Etapa;
import com.poli.productApp.service.EtapaService;

@RestController
@RequestMapping("/api/etapas")
@CrossOrigin(origins = "*")
public class EtapaController {

    private final EtapaService etapaService;

    public EtapaController(EtapaService etapaService) {
        this.etapaService = etapaService;
    }

    @PostMapping
    public ResponseEntity<Etapa> crearEtapa(@RequestBody Etapa etapa) {
        Etapa nuevaEtapa = etapaService.guardar(etapa);
        return ResponseEntity.ok(nuevaEtapa);
    }

    @GetMapping
    public ResponseEntity<List<Etapa>> listarEtapas() {
        return ResponseEntity.ok(etapaService.listar());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Etapa> obtenerEtapa(@PathVariable Long id) {
        return ResponseEntity.ok(etapaService.obtenerPorId(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Etapa> actualizarEtapa(@PathVariable Long id, @RequestBody Etapa etapa) {
        return ResponseEntity.ok(etapaService.actualizar(id, etapa));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarEtapa(@PathVariable Long id) {
        etapaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
