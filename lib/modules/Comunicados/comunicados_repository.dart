import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ComunicadosRepository {
  static Future getComunicados() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("admautopecasbelem.com.br", "login/flutter/comunicados.php"),
      body: {
        'idusu': loginController.idusu.value,
      },
    );
  }
}
