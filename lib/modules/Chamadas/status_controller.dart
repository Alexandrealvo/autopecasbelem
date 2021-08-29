import 'dart:convert';
import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:http/http.dart' as http;
import 'package:apbelem/modules/Chamadas/chamadas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  ChamadasController chamadasController = Get.put(ChamadasController());

  var firstId = '0'.obs;
  var isLoading = true.obs;
  var observacao = TextEditingController().obs;

  List<String> tipos = [
    'SELECIONE O STATUS',
    'ABERTO',
    'FECHADO TEMPORARIAMENTE',
    'FECHADO',
    'EM REFORMA',
  ];

  var itemSelecionado = "SELECIONE O STATUS".obs;

  getStatusCliente(String idchamada, String statuscliente) async {
    LoginController loginController = Get.put(LoginController());
    //StatusController statusController = Get.put(StatusController());
    //ChamadasController chamadasController = Get.put(ChamadasController());

    isLoading(true);

    if (observacao.value.text == '' || statuscliente == 'SELECIONE O STATUS') {
      return 'vazio';
    } else {
      var response = await http.post(
          Uri.https("www.admautopecasbelem.com.br",
              "/login/flutter/status_mudar_cliente.php"),
          body: {
            'idchamada': idchamada,
            'statuscliente': statuscliente,
            'observacao': observacao.value.text,
            'idusu': loginController.idusu.value,
          });
      var dados = json.decode(response.body);

      chamadasController.observacao.value = observacao.value.text;

      isLoading(false);

      return dados;
    }
  }

  init() {
    itemSelecionado.value = chamadasController.statuscliente.value;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
