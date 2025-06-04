package com.poli.productApp.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poli.productApp.model.archivoTecnico.ArchivoTecnico;
import com.poli.productApp.repository.ArchivoTecnicoRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ArchivoTecnicoService {

    @Autowired
    private ArchivoTecnicoRepository archivoTecnicoRepository;


    public ArchivoTecnico guardarArchivo(ArchivoTecnico archivo) {
        return archivoTecnicoRepository.save(archivo);
    }

    public List<ArchivoTecnico> listarTodos() {
        return archivoTecnicoRepository.findAll();
    }


    public List<ArchivoTecnico> listarArchivos() {
        return archivoTecnicoRepository.findAll();
    }


    public Optional<ArchivoTecnico> obtenerArchivoPorId(Long id) {
        return archivoTecnicoRepository.findById(id);
    }


    public Optional<ArchivoTecnico> obtenerPorId(Long id) {
        return archivoTecnicoRepository.findById(id);
    }

    public ArchivoTecnico guardar(ArchivoTecnico archivo) {
        return archivoTecnicoRepository.save(archivo);
    }

    public void eliminar(Long id) {
        archivoTecnicoRepository.deleteById(id);
    }

    public Optional<ArchivoTecnico> actualizarArchivo(Long id, ArchivoTecnico datosNuevos) {
        return archivoTecnicoRepository.findById(id).map(archivo -> {
            archivo.setNombre(datosNuevos.getNombre());
            archivo.setTipoArchivo(datosNuevos.getTipoArchivo());
            archivo.setUrl(datosNuevos.getUrl());
            archivo.setOrdenTrabajo(datosNuevos.getOrdenTrabajo());
            archivo.setUsuario(datosNuevos.getUsuario());
            archivo.setEtapaProduccion(datosNuevos.getEtapaProduccion());
            return archivoTecnicoRepository.save(archivo);
        });
    }


    public boolean eliminarArchivo(Long id) {
        if (archivoTecnicoRepository.existsById(id)) {
            archivoTecnicoRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
