package com.poli.productApp.service;

import java.util.List;

import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poli.productApp.model.etapa.Etapa;
import com.poli.productApp.repository.EtapaRepository;

import jakarta.persistence.EntityNotFoundException;
import com.poli.productApp.repository.OrdenTrabajoRepository;


@Service
public class EtapaService {

    private final EtapaRepository etapaRepository;
    private final OrdenTrabajoRepository ordenTrabajoRepository;

    public EtapaService(EtapaRepository etapaRepository, OrdenTrabajoRepository ordenTrabajoRepository) {
        this.etapaRepository = etapaRepository;
        this.ordenTrabajoRepository = ordenTrabajoRepository;
    }

    @Transactional
    public Etapa guardar(Etapa etapa) {
        return etapaRepository.save(etapa);
    }

    public List<Etapa> listar() {
        return etapaRepository.findAll();
    }

    public Etapa obtenerPorId(Long id) {
        return etapaRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Etapa no encontrada con ID: " + id));
    }

    @Transactional
    public Etapa actualizar(Long id, Etapa etapaActualizada) {
        Etapa etapa = obtenerPorId(id);
        etapa.setNombre(etapaActualizada.getNombre());
        etapa.setDescripcion(etapaActualizada.getDescripcion());
        return etapaRepository.save(etapa);
    }

    @Transactional
    public void eliminar(Long id) {
        if (!etapaRepository.existsById(id)) {
            throw new EntityNotFoundException("Etapa no encontrada con ID: " + id);
        }
        etapaRepository.deleteById(id);
    }

    @Transactional
    public void asignarEtapasAOden(Long ordenId, List<Long> etapaIds) {
        OrdenTrabajo orden = ordenTrabajoRepository.findById(ordenId)
                .orElseThrow(() -> new EntityNotFoundException("Orden no encontrada"));

        List<Etapa> etapas = etapaRepository.findAllById(etapaIds);

        for (Etapa etapa : etapas) {
            etapa.setOrdenTrabajo(orden);
        }

        etapaRepository.saveAll(etapas);
    }




}
