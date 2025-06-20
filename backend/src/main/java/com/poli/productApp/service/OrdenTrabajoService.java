package com.poli.productApp.service;

import com.poli.productApp.model.ENUMS.Estado;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.repository.OrdenTrabajoRepository;

import lombok.Getter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OrdenTrabajoService {

    @Autowired
    private OrdenTrabajoRepository repository;

    public OrdenTrabajo guardar(OrdenTrabajo ordenTrabajo) {
        return repository.save(ordenTrabajo);
    }

    public List<OrdenTrabajo> listar() {
        return repository.findAll();
    }

    public Optional<OrdenTrabajo> obtenerPorId(Long id) {
        return repository.findById(id);
    }

    public OrdenTrabajo actualizar(Long id, OrdenTrabajo ordenActualizada) {
        return repository.findById(id).map(orden -> {
            orden.setDescripcion(ordenActualizada.getDescripcion());
            orden.setFechaInicio(ordenActualizada.getFechaInicio());
            orden.setFechaFin(ordenActualizada.getFechaFin());
            orden.setEstado(ordenActualizada.getEstado());
            orden.setUsuario(ordenActualizada.getUsuario());
            orden.setEtapasProduccion(ordenActualizada.getEtapasProduccion());
            return repository.save(orden);
        }).orElseThrow(() -> new RuntimeException("Orden no encontrada con ID: " + id));
    }

    public OrdenTrabajo actualizarEstado(Long id, Estado nuevoEstado) {
        return repository.findById(id).map(orden -> {
            orden.setEstado(nuevoEstado);
            return repository.save(orden);
        }).orElseThrow(() -> new RuntimeException("Orden no encontrada con ID: " + id));
    }

    public void eliminar(Long id) {
        repository.deleteById(id);
    }

    public List<OrdenTrabajo> buscarPorEstado(Estado estado) {
        return repository.findByEstado(estado);
    }

}
