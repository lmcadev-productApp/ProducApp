package com.poli.productApp.controller;

import com.poli.productApp.model.etapa.EtapaProduccion;
import com.poli.productApp.model.ENUMS.Estado;
import com.poli.productApp.model.etapa.Etapa;
import com.poli.productApp.model.ordenTrabajo.OrdenTrabajo;
import com.poli.productApp.model.usuario.Usuario;
import com.poli.productApp.repository.EtapaProduccionRepository;
import com.poli.productApp.repository.EtapaRepository;
import com.poli.productApp.repository.OrdenTrabajoRepository;
import com.poli.productApp.repository.UsuarioRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;
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

    @PostMapping
    public ResponseEntity<?> crearEtapaProduccion(@RequestParam Long ordenId,
                                                  @RequestParam Long etapaId,
                                                  @RequestParam Long empleadoId,
                                                  @RequestParam String estado,
                                                  @RequestParam Date fechaInicio,
                                                  @RequestParam Date fechaFin) {
        Optional<OrdenTrabajo> ordenOpt = ordenTrabajoRepository.findById(ordenId);
        Optional<Etapa> etapaOpt = etapaRepository.findById(etapaId);
        Optional<Usuario> usuarioOpt = usuarioRepository.findById(empleadoId);

        if (ordenOpt.isEmpty() || etapaOpt.isEmpty() || usuarioOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Orden, etapa o empleado no encontrados");
        }

        EtapaProduccion ep = new EtapaProduccion();
        ep.setOrdenTrabajo(ordenOpt.get());
        ep.setEtapa(etapaOpt.get());
        ep.setUsuario(usuarioOpt.get());
        ep.setEstado(Estado.valueOf(estado));
        ep.setFechaInicio(fechaInicio);
        ep.setFechaFin(fechaFin);

        etapaProduccionRepository.save(ep);
        return ResponseEntity.ok("Etapa de producción creada correctamente");
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
