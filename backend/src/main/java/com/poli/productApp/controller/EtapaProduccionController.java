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
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;



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
            // Validar existencia de claves necesarias
            if (!body.containsKey("ordenId") || !body.containsKey("registradoPor") || !body.containsKey("etapaIds")) {
                return ResponseEntity.badRequest().body("Faltan datos obligatorios: 'ordenId', 'registradoPor', o 'etapaIds'");
            }
            System.out.println("Datos recibidos: " + body);

            // Extraer y convertir los datos del cuerpo de la solicitud
            Long ordenId = Long.valueOf(body.get("ordenId").toString());
            Long registradoPor = Long.valueOf(body.get("registradoPor").toString());


            Date fechaInicio = null;
            Date fechaFin = null;

            // Convertir etapaIds a lista de enteros (acepta lista o un solo valor)
            Object etapaIdsObj = body.get("etapaIds");
            List<Integer> etapaIds;

            if (etapaIdsObj instanceof List<?>) {
                etapaIds = ((List<?>) etapaIdsObj).stream()
                        .map(o -> Integer.parseInt(o.toString()))
                        .collect(Collectors.toList());
            } else {
                etapaIds = List.of(Integer.parseInt(etapaIdsObj.toString()));
            }

            // Buscar la orden de trabajo y el usuario en la base de datos
            Optional<OrdenTrabajo> ordenOpt = ordenTrabajoRepository.findById(ordenId);
            Optional<Usuario> registradoPorOpt = usuarioRepository.findById(registradoPor);


            if (ordenOpt.isEmpty() || registradoPorOpt.isEmpty()) {
                return ResponseEntity.badRequest().body("Orden de trabajo o usuario no encontrados");
            }

            // Asociar etapas a EtapaProduccion usando EtapaList
            for (Integer etapaId : etapaIds) {
                // Crear una nueva instancia de EtapaProduccion
                EtapaProduccion ep = new EtapaProduccion();
                ep.setEstado(Estado.PENDIENTE);
                ep.setFechaInicio(fechaInicio);
                ep.setFechaFin(fechaFin);
                ep.setOrdenTrabajo(ordenOpt.get());
                ep.setUsuario(null);
                ep.setRegistradoPor(registradoPorOpt.get());

                Optional<Etapa> etapaOpt = etapaRepository.findById(etapaId.longValue());
                if (etapaOpt.isEmpty()) continue;

                ep.setEtapa(etapaOpt.get());


                // Guardar la EtapaProduccion
                EtapaProduccion guardada = etapaProduccionRepository.save(ep);
            }

            return ResponseEntity.ok("EtapaProduccion creada con lista de etapas");

        } catch (Exception e) {
            e.printStackTrace(); // Útil para depurar en consola
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
