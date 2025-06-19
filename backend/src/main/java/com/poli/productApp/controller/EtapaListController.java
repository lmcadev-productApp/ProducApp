package com.poli.productApp.controller;

import com.poli.productApp.model.etapa.Etapa;
import com.poli.productApp.model.etapa.EtapaList;
import com.poli.productApp.model.etapa.EtapaProduccion;
import com.poli.productApp.repository.EtapaListRepository;
import com.poli.productApp.repository.EtapaProduccionRepository;
import com.poli.productApp.repository.EtapaRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/etapa-list")
@CrossOrigin(origins = "*")
public class EtapaListController {

    @Autowired
    private EtapaListRepository etapaListRepository;

    @Autowired
    private EtapaProduccionRepository etapaProduccionRepository;

    @Autowired
    private EtapaRepository etapaRepository;


    @GetMapping("/por-produccion/{etapaProduccionId}")
    public ResponseEntity<List<EtapaList>> getByEtapaProduccionId(@PathVariable Long etapaProduccionId) {
        List<EtapaList> lista = etapaListRepository.findByEtapaProduccionId(etapaProduccionId);
        return ResponseEntity.ok(lista);
    }

 
    @GetMapping("/por-etapa/{etapaId}")
    public ResponseEntity<List<EtapaList>> getByEtapaId(@PathVariable Long etapaId) {
        List<EtapaList> lista = etapaListRepository.findByEtapaId(etapaId);
        return ResponseEntity.ok(lista);
    }

   
    @PostMapping
    public ResponseEntity<?> crearEtapaProduccion(@RequestParam Long etapaProduccionId,
                                           @RequestParam Long etapaId) {
        Optional<EtapaProduccion> epOpt = etapaProduccionRepository.findById(etapaProduccionId);
        Optional<Etapa> etapaOpt = etapaRepository.findById(etapaId);

        if (epOpt.isEmpty() || etapaOpt.isEmpty()) {
            if(epOpt.isEmpty()){
                return ResponseEntity.badRequest().body("Etapa de Produccion no encontrada");
            }
            else {
                return ResponseEntity.badRequest().body("Etapa no encontrada");
            }

        }

        EtapaList nueva = new EtapaList();
        nueva.setEtapaProduccion(epOpt.get());
        nueva.setEtapa(etapaOpt.get());

        etapaListRepository.save(nueva);
        EtapaProduccionRepository.save(epOpt.get());
        return ResponseEntity.ok("Relación etapa-producción creada correctamente");
    }
}
