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

import com.poli.productApp.service.OrdenTrabajoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
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
    @Autowired
    private OrdenTrabajoService ordenTrabajoService;


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

            //Actualiza estado de orden de trabajo
            ordenTrabajoService.actualizarEstado(ordenId, Estado.EN_PROCESO);
            return ResponseEntity.ok("EtapaProduccion creada con lista de etapas");

        } catch (Exception e) {
            e.printStackTrace(); // Útil para depurar en consola
            return ResponseEntity.badRequest().body("Error al crear estructura completa: " + e.getMessage());
        }
    }

//get all etapas de produccion
    @GetMapping("/")
    public ResponseEntity<List<EtapaProduccion>> getAllEtapasProduccion() {
        List<EtapaProduccion> etapas = etapaProduccionRepository.findAll();
        return ResponseEntity.ok(etapas);
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

    //consulta todas las etapas de produccion filtadas por estado ASIGNADA
    @GetMapping("/por-estado/{estado}")
    public ResponseEntity<List<EtapaProduccion>> getEtapasPorEstado(@PathVariable String estado) {
        try {
            // Convierte el String a Enum
            Estado estadoEnum = Estado.valueOf(estado.trim().toUpperCase().replace(" ", "_"));
            // Busca las etapas por estado en el repositorio
            List<EtapaProduccion> etapas = etapaProduccionRepository.findByEstado(estadoEnum);
            return ResponseEntity.ok(etapas);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(null); // Estado inválido
        }
    }

    //asignar operarios a etapas de produccion por id
    @PutMapping("/asignar-operario/{etapaId}")
    public ResponseEntity<?> asignarOperarioEtapa(@PathVariable Long etapaId, @RequestBody Map<String, Object> body) {


        System.out.println("Datos: " + body + " Etapa ID: " + etapaId);

        if (!body.containsKey("usuarioId")) {
            return ResponseEntity.badRequest().body("Falta el ID del usuario a asignar");
        }

        Long usuarioId = Long.valueOf(body.get("usuarioId").toString());
        String estadoStr = (String) body.get("estado");
        String fechaInicioStr = (String) body.get("fechaInicio");

        Optional<EtapaProduccion> etapaOpt = etapaProduccionRepository.findById(etapaId);
        Optional<Usuario> usuarioOpt = usuarioRepository.findById(usuarioId);

        System.out.println("Etapa ID: " + etapaId);
        System.out.println("Usuario ID: " + usuarioId);
        System.out.println("Etapa encontrada: " + etapaOpt);
        System.out.println("Usuario encontrado: " + usuarioOpt);


        if (etapaOpt.isEmpty() || usuarioOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Etapa o usuario no encontrado");
        }

        EtapaProduccion etapa = etapaOpt.get();
        etapa.setUsuario(usuarioOpt.get());

// Parsear y setear estado
        if (estadoStr != null) {
            try {
                etapa.setEstado(Estado.valueOf(estadoStr.toUpperCase()));
            } catch (IllegalArgumentException e) {
                return ResponseEntity.badRequest().body("Estado inválido");
            }
        }

// Parsear y setear fecha
        if (fechaInicioStr != null) {
            try {
                LocalDate localDate = LocalDate.parse(fechaInicioStr); // formato ISO
                etapa.setFechaInicio(Date.valueOf(localDate));
            } catch (DateTimeParseException e) {
                return ResponseEntity.badRequest().body("Formato de fecha inválido. Usa yyyy-MM-dd.");
            }
        }

        etapaProduccionRepository.save(etapa);
        return ResponseEntity.ok("Operario asignado correctamente");

    }

    //etapa de produccion por id de usuario y estado
    @GetMapping("/usuario/{usuarioId}")
    public ResponseEntity<List<EtapaProduccion>> getEtapasPorUsuarioYMultiplesEstados(@PathVariable Long usuarioId) {
        try {
            List<Estado> estados = List.of(Estado.ASIGNADA, Estado.EN_PROCESO);
            System.out.println("Consultando etapas para usuario: " + usuarioId + " con estados: " + estados);
            List<EtapaProduccion> etapas = etapaProduccionRepository.findByUsuarioIdAndEstadoIn(usuarioId, estados);
            System.out.println("Etapas encontradas: " + etapas.size());
            return ResponseEntity.ok(etapas);
        } catch (Exception e) {
            e.printStackTrace(); // Imprime la excepción si ocurre
            return ResponseEntity.badRequest().body(null);
        }
    }


    //cambia estado de etapa de produccion por id
    @PutMapping("/cambiar-estado/{etapaId}")
    public ResponseEntity<?> cambiarEstadoEtapa(@PathVariable Long etapaId, @RequestBody Map<String, Object> body) {
        if (!body.containsKey("estado")) {
            return ResponseEntity.badRequest().body("Falta el estado a cambiar");
        }

        String estadoStr = (String) body.get("estado");
        Optional<EtapaProduccion> etapaOpt = etapaProduccionRepository.findById(etapaId);

        if (etapaOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Etapa no encontrada");
        }

        EtapaProduccion etapa = etapaOpt.get();

        try {
            Estado nuevoEstado = Estado.valueOf(estadoStr.toUpperCase());
            etapa.setEstado(nuevoEstado);
            etapaProduccionRepository.save(etapa);
            return ResponseEntity.ok("Estado cambiado correctamente");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("Estado inválido");
        }
    }

    //cambia estado a "COMPLETADO" de etapa de produccion por id y pasa fecha de finalización
    @PutMapping("/completar/{etapaId}")
    public ResponseEntity<?> completarEstado(@PathVariable Long etapaId, @RequestBody Map<String, Object> body) {
        if (!body.containsKey("estado")) {
            return ResponseEntity.badRequest().body("Falta el estado a cambiar");
        }
        if (!body.containsKey("fechaFin")) {
            return ResponseEntity.badRequest().body("Falta la fecha de finalización");
        }

        String estadoStr = (String) body.get("estado");
        String fechaFinStr = (String) body.get("fechaFin");

        Optional<EtapaProduccion> etapaOpt = etapaProduccionRepository.findById(etapaId);
        if (etapaOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Etapa no encontrada");
        }

        try {
            Estado nuevoEstado = Estado.valueOf(estadoStr.toUpperCase());
            Date fechaFin = Date.valueOf(fechaFinStr); // formato: yyyy-MM-dd

            EtapaProduccion etapa = etapaOpt.get();
            etapa.setEstado(nuevoEstado);
            etapa.setFechaFin(fechaFin);
            etapaProduccionRepository.save(etapa);

            return ResponseEntity.ok("Estado cambiado correctamente");

        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("Estado o fecha inválidos: " + e.getMessage());
        }
    }



}
