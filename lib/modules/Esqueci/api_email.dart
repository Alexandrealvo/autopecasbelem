
import 'package:apbelem/modules/Esqueci/email_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiEmail {
  static Future email() async {
    EmailController emailController = Get.put(EmailController());
    return await http.post(
      Uri.https('admautopecasbelem.com.br', '/login/flutter/lembrar_senha.php'),
      body: {
        'email': emailController.emailesqueci.value.text,
      },
    );
  }
}
