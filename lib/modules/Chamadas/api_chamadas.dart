import 'dart:convert';
import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApiChamadas extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getChamadas();
    refreshController.refreshCompleted();
  }

  static Future getChamadas() async {
    LoginController loginController = Get.put(LoginController());
    print(loginController.idusu.value);

    return await http.get(Uri.https("www.admautopecasbelem.com.br",
        "/login/flutter/chamadas.php", {"idusu": loginController.idusu.value}));
  }

  static Future getAceitar(String idchamada, String status) async {
    LoginController loginController = Get.put(LoginController());
    var response = await http.post(
        Uri.https("www.admautopecasbelem.com.br",
            "/login/flutter/chamada_aceitar.php"),
        body: {
          'idusu': loginController.idusu.value,
          'idchamada': idchamada,
          'status': status,
        });
    var dados = json.decode(response.body);
    return dados;
  }

  

  @override
  void onInit() {
    super.onInit();
    getChamadas();
  }
}
