package com.poli.productApp.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.poli.productApp.model.archivoTecnico.ArchivoTecnico;
import com.poli.productApp.service.ArchivoTecnicoService;

@RestController
@RequestMapping("/api/archivos-tecnicos")
public class ArchivoTecnicoController {

    @Autowired
    private ArchivoTecnicoService archivoTecnicoService;

    @GetMapping
    public List<ArchivoTecnico> listar() {
        return archivoTecnicoService.listarTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ArchivoTecnico> obtenerPorId(@PathVariable Long id) {
        Optional<ArchivoTecnico> archivo = archivoTecnicoService.obtenerPorId(id);
        return archivo.map(ResponseEntity::ok)
                      .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<ArchivoTecnico> crear(@RequestBody ArchivoTecnico archivo) {
        return ResponseEntity.ok(archivoTecnicoService.guardar(archivo));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ArchivoTecnico> actualizar(@PathVariable Long id, @RequestBody ArchivoTecnico nuevoArchivo) {
        Optional<ArchivoTecnico> archivoExistente = archivoTecnicoService.obtenerPorId(id);
        if (archivoExistente.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        ArchivoTecnico archivo = archivoExistente.get();
        archivo.setNombre(nuevoArchivo.getNombre());
        archivo.setTipoArchivo(nuevoArchivo.getTipoArchivo());
        archivo.setUrl(nuevoArchivo.getUrl());
        archivo.setOrdenTrabajo(nuevoArchivo.getOrdenTrabajo());
        archivo.setUsuario(nuevoArchivo.getUsuario());
        archivo.setEtapaProduccion(nuevoArchivo.getEtapaProduccion());

        return ResponseEntity.ok(archivoTecnicoService.guardar(archivo));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        if (archivoTecnicoService.obtenerPorId(id).isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        archivoTecnicoService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
