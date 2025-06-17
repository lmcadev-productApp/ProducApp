package com.poli.productApp.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.poli.productApp.service.EtapaService;



@RestController
@RequestMapping("/api/ordenes")
@CrossOrigin(origins = "*")
public class OrdenEtapaController {

    private final EtapaService etapaService;

    public OrdenEtapaController(EtapaService etapaService) {
        this.etapaService = etapaService;
    }

}
