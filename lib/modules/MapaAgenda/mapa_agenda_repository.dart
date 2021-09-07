import 'package:apbelem/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MapaAgendaRepository {
  static Future doCheckin() async {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());

    print({
      mapaAgendaController.idVisita.value,
      mapaAgendaController.lat.value.toString(),
      mapaAgendaController.lng.value.toString(),
      mapaAgendaController.ctlcheckin.value,
      mapaAgendaController.ourLat.value.toString(),
      mapaAgendaController.ourLng.value.toString()
    });

    return await http.post(
      Uri.https("www.admautopecasbelem.com.br", "/login/flutter/check.php"),
      body: {
        'idvisita': mapaAgendaController.idVisita.value,
        'lat': mapaAgendaController.ourLat.value.toString(),
        'lng': mapaAgendaController.ourLng.value.toString(),
        'latcliente': mapaAgendaController.lat.value.toString(),
        'lngcliente': mapaAgendaController.lng.value.toString(),
        'ctlcheckin': mapaAgendaController.ctlcheckin.value,
      },
    );
  }
}
