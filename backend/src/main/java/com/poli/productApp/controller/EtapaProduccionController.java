package com.poli.productApp.controller;

import com.poli.productApp.model.etapa.EtapaProduccion;
import com.poli.productApp.model.ENUMS.Estado;
import com.poli.productApp.model.etapa.Etapa;
import com.poli.productApp.model.etapa.EtapaList;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.model.usuario.Usuario;
import com.poli.productApp.repository.EtapaProduccionRepository;
import com.poli.productApp.repository.EtapaRepository;
import com.poli.productApp.repository.OrdenTrabajoRepository;
import com.poli.productApp.repository.UsuarioRepository;
import com.poli.productApp.repository.EtapaListRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/etapas-produccion")
public class EtapaProduccionController {

    @Autowired
    private EtapaProduccionRepository etapaProduccionRepository;

    @Autowired
    private OrdenTrabajoRepository ordenTrabajoRepository;

    @Autowired
    private EtapaRepository etapaRepository;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private EtapaListRepository etapaListRepository;

    @PostMapping("/crear")
public ResponseEntity<?> crearEtapaProduccionConLista(@RequestBody Map<String, Object> body) {
    try {
        Long ordenId = Long.valueOf(body.get("ordenId").toString());
        Long usuarioId = Long.valueOf(body.get("usuarioId").toString());
        String estado = body.get("estado").toString();
        Date fechaInicio = Date.valueOf(body.get("fechaInicio").toString().substring(0, 10));
        Date fechaFin = Date.valueOf(body.get("fechaFin").toString().substring(0, 10));

        List<Integer> etapaIds = (List<Integer>) body.get("etapaIds");

        Optional<OrdenTrabajo> ordenOpt = ordenTrabajoRepository.findById(ordenId);
        Optional<Usuario> usuarioOpt = usuarioRepository.findById(usuarioId);

        if (ordenOpt.isEmpty() || usuarioOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Orden o usuario no encontrados");
        }

        // Crear etapa_produccion sin asignar etapa directamente
        EtapaProduccion ep = new EtapaProduccion();
        ep.setOrdenTrabajo(ordenOpt.get());
        ep.setUsuario(usuarioOpt.get());
        ep.setEstado(Estado.valueOf(estado));
        ep.setFechaInicio(fechaInicio);
        ep.setFechaFin(fechaFin);

        EtapaProduccion guardada = etapaProduccionRepository.save(ep);

        // Guardar en tabla etapa_list
        for (Integer etapaId : etapaIds) {
            Optional<Etapa> etapaOpt = etapaRepository.findById(etapaId.longValue());
            if (etapaOpt.isEmpty()) continue;

            EtapaList lista = new EtapaList();
            lista.setEtapa(etapaOpt.get());
            lista.setEtapaProduccion(guardada);
            etapaListRepository.save(lista);
        }

        return ResponseEntity.ok("EtapaProduccion creada con lista de etapas");

    } catch (Exception e) {
        return ResponseEntity.badRequest().body("Error al crear estructura completa: " + e.getMessage());
    }
}


      // Consultar por orden de trabajo
    @GetMapping("/por-orden/{ordenId}")
    public ResponseEntity<List<EtapaProduccion>> getEtapasPorOrden(@PathVariable Long ordenId) {
        List<EtapaProduccion> etapas = etapaProduccionRepository.findByOrdenTrabajoId(ordenId);
        return ResponseEntity.ok(etapas);
    }

    // Consultar por empleado asignado
    @GetMapping("/por-empleado/{empleadoId}")
    public ResponseEntity<List<EtapaProduccion>> getEtapasPorEmpleado(@PathVariable Long empleadoId) {
        List<EtapaProduccion> etapas = etapaProduccionRepository.findByUsuarioId(empleadoId);
        return ResponseEntity.ok(etapas);
    }
}
