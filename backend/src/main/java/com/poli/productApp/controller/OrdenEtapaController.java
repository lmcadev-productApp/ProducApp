package com.poli.productApp.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.poli.productApp.service.EtapaService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import java.util.List;


@RestController
@RequestMapping("/api/ordenes")
@CrossOrigin(origins = "*")
public class OrdenEtapaController {

    private final EtapaService etapaService;

    public OrdenEtapaController(EtapaService etapaService) {
        this.etapaService = etapaService;
    }

    @PostMapping("/{ordenId}/etapas")
    public ResponseEntity<String> asignarEtapas(
            @PathVariable Long ordenId,
            @RequestBody List<Long> etapaIds
    ) {
        etapaService.asignarEtapasAOden(ordenId, etapaIds);
        return ResponseEntity.ok("Etapas asignadas");
    }
}
