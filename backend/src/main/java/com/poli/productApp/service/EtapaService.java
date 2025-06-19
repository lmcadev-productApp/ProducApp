package com.poli.productApp.service;


import java.util.List;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.poli.productApp.model.etapa.Etapa;
import com.poli.productApp.repository.EtapaRepository;
import jakarta.persistence.EntityNotFoundException;



@Service
public class EtapaService {
    private final EtapaRepository etapaRepository;


    public EtapaService(EtapaRepository etapaRepository) {
        this.etapaRepository = etapaRepository;

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

  





}
