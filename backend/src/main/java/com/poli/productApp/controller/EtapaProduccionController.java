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

    /**
 * Endpoint para crear una nueva EtapaProduccion junto con una lista de etapas asociadas.
 *
 * @param body Un mapa que contiene los siguientes datos requeridos:
 *             - "ordenId" (Long): ID de la orden de trabajo asociada.
 *             - "registradoPor" (Long): ID del usuario que registra la etapa.
 *             - "etapaIds" (List<Integer>): Lista de IDs de las etapas asociadas.
 *
 * @return ResponseEntity con un mensaje de éxito si la creación es exitosa, o un mensaje de error si ocurre algún problema.
 */
@PostMapping("/crear")
public ResponseEntity<?> crearEtapaProduccionConLista(@RequestBody Map<String, Object> body) {
    try {
        // Extraer y convertir los datos del cuerpo de la solicitud
        Long ordenId = Long.valueOf(body.get("ordenId").toString());
        Long registradoPor = Long.valueOf(body.get("registradoPor").toString());
        Long usuarioId = null;
        String estado = "PENDIENTE";
        Date fechaInicio = null;
        Date fechaFin = null;


        // Obtener la lista de IDs de etapas
        List<Integer> etapaIds = (List<Integer>) body.get("etapaIds");

        // Buscar la orden de trabajo y el usuario en la base de datos
        Optional<OrdenTrabajo> ordenOpt = ordenTrabajoRepository.findById(ordenId);
        Optional<Usuario> registradoPorOpt = usuarioRepository.findById(registradoPor);

        // Validar que la orden de trabajo y el usuario existan
        if (ordenOpt.isEmpty() || registradoPorOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Orden o usuario no encontrados");
        }

        // Crear una nueva instancia de EtapaProduccion
        EtapaProduccion ep = new EtapaProduccion();
        ep.setEstado(Estado.valueOf(estado));
        ep.setFechaInicio(fechaInicio);
        ep.setFechaFin(fechaFin);
        ep.setOrdenTrabajo(ordenOpt.get());
        ep.setUsuario(null);
        ep.setRegistradoPor(registradoPorOpt.get());

        // Guardar la EtapaProduccion en la base de datos
        EtapaProduccion guardada = etapaProduccionRepository.save(ep);

        // Asociar las etapas a la EtapaProduccion y guardarlas en la tabla EtapaList
        for (Integer etapaId : etapaIds) {
            Optional<Etapa> etapaOpt = etapaRepository.findById(etapaId.longValue());
            if (etapaOpt.isEmpty()) continue;

            EtapaList lista = new EtapaList();
            lista.setEtapa(etapaOpt.get());
            lista.setEtapaProduccion(guardada);
            etapaListRepository.save(lista);
        }

        // Retornar una respuesta de éxito
        return ResponseEntity.ok("EtapaProduccion creada con lista de etapas");

    } catch (Exception e) {
        // Manejar errores y retornar una respuesta de error
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
