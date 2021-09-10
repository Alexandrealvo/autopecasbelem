import 'package:apbelem/modules/AgendarHorario/agendarhorario.controller.dart';
import 'package:apbelem/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AgendarRepository {
  static Future changeHours() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());
    AgendaHorarioController agendaHorarioController =
        Get.put(AgendaHorarioController());

    return await http.post(
      Uri.https(
          "www.admautopecasbelem.com.br", "login/flutter/agendar_horario.php"),
      body: {
        'idvisita': mapaAgendaController.idVisita.value,
        'time': agendaHorarioController.hour.value.text,
      },
    );
  }
}
