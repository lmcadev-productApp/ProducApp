package com.poli.productApp.service;

import com.poli.productApp.model.especialidad.Especialidad;
import com.poli.productApp.repository.EspecialidadRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EspecialidadService {

    @Autowired
    private EspecialidadRepository especialidadRepository;

    public List<Especialidad> listarTodas() {
        return especialidadRepository.findAll();
    }

    public Optional<Especialidad> buscarPorId(Long id) {
        return especialidadRepository.findById(id);
    }

    public Especialidad guardar(Especialidad especialidad) {
        return especialidadRepository.save(especialidad);
    }

    public Optional<Especialidad> actualizar(Long id, Especialidad nueva) {
        return especialidadRepository.findById(id).map(especialidad -> {
            especialidad.setNombre(nueva.getNombre());
            return especialidadRepository.save(especialidad);
        });
    }

    public boolean eliminar(Long id) {
        return especialidadRepository.findById(id).map(especialidad -> {
            especialidadRepository.delete(especialidad);
            return true;
        }).orElse(false);
    }
}
