import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiCalendario {
  static Future getCalendario() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("www.admautopecasbelem.com.br",
          "/login/flutter/agenda_visualizar.php"),
      body: {
        'idusu': loginController.idusu.value,
      },
    );
  }
}
