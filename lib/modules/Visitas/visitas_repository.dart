import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:apbelem/modules/Visitas/visitas_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VisitasRepository {
  static Future getVisitantes() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("www.admautopecasbelem.com.br",
          "/login/flutter/visitas_clientes_pesquisa.php"),
      body: {
        'idusu': loginController.idusu.value,
      },
    );
  }

  static Future doRelatorios() async {
    LoginController loginController = Get.put(LoginController());
    VisitasController visitasController = Get.put(VisitasController());

    print({
      loginController.idusu.value,
      visitasController.firstId.value,
      visitasController.initialDate.value,
      visitasController.finalDate.value,
    });

    return await http.post(
      Uri.https("www.admautopecasbelem.com.br",
          "login/flutter/visitas_relatorio.php"),
      body: {
        'idusu': loginController.idusu.value,
        'idcliente': visitasController.firstId.value,
        'datainicial': visitasController.initialDate.value,
        'datafinal': visitasController.finalDate.value,
      },
    );
  }
}
