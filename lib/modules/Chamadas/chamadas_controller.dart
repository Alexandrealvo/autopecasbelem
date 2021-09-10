import 'dart:convert';
import 'package:apbelem/modules/Chamadas/api_chamadas.dart';
import 'package:apbelem/modules/Chamadas/mapa_chamadas.dart';
import 'package:get/get.dart';

class ChamadasController extends GetxController {
  var chamadas = <Dadoschamadas>[].obs;
  var idchamada = ''.obs;
  var nomecliente = ''.obs;
  var datacliente = ''.obs;
  var endereco = ''.obs;
  var tel = ''.obs;
  var cel = ''.obs;
  var whatsapp = ''.obs;
  var responsavel = ''.obs;
  var whatresp = ''.obs;
  var status = ''.obs;
  var statuscliente = ''.obs;
  var observacao = ''.obs;
  var lat = ''.obs;
  var lng = ''.obs;
  var isLoading = true.obs;

  getChamadas() {
    isLoading(true);
    ApiChamadas.getChamadas().then((response) {
      Iterable lista = json.decode(response.body);
      chamadas.assignAll(
          lista.map((model) => Dadoschamadas.fromJson(model)).toList());
      isLoading(false);
    });
  }


  @override
  void onInit() {
    super.onInit();
  }
}
