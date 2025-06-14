package com.poli.productApp.service;

import com.poli.productApp.model.etapa.EtapaProduccion;
import com.poli.productApp.model.ENUMS.Estado;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import com.poli.productApp.repository.OrdenTrabajoRepository;

import org.springframework.beans.factory.annotation.Autowired;
import com.poli.productApp.repository.EtapaProduccionRepository;
import org.springframework.stereotype.Service;

@Service
public class EtapaProduccionService {

    @Autowired
    private EtapaProduccionRepository etapaProduccionRepository;

    @Autowired
    private OrdenTrabajoRepository ordenTrabajoRepository;

    @Transactional
    public EtapaProduccion completarEtapa(Long id) {
        java.util.List<EtapaProduccion> etapas = etapaProduccionRepository.findByOrdenTrabajoId(id);
        if (etapas.isEmpty()) {
            throw new EntityNotFoundException("Etapa no encontrada");
        }
        EtapaProduccion etapa = etapas.get(0);

        etapa.setEstado(Estado.COMPLETADO);
        etapaProduccionRepository.save(etapa);

        // Verificar si todas las etapas de la orden están completadas
        OrdenTrabajo orden = etapa.getOrdenTrabajo();
        boolean todasCompletas = orden.getEtapas().stream()
                .allMatch(e -> e.getEstado() == Estado.COMPLETADO);

        if (todasCompletas) {
            orden.setEstado(Estado.COMPLETADO);
            ordenTrabajoRepository.save(orden);
        }

        return etapa;
    }
}
