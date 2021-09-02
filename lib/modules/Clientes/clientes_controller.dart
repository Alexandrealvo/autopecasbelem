import 'dart:convert';
import 'package:apbelem/modules/Clientes/api_clientes.dart';
import 'package:apbelem/modules/Clientes/mapa_clientes.dart';
import 'package:get/get.dart';

class ClientesController extends GetxController {
  var clientes = <Dadosclientes>[].obs;
  var idcliente = ''.obs;
  var nomecliente = ''.obs;
  var datacliente = ''.obs;
  var endereco = ''.obs;
  var end = ''.obs;
  var numero = ''.obs;
  var bairro = ''.obs;
  var cidade = ''.obs;
  var uf = ''.obs;
  var cep = ''.obs;
  var tel = ''.obs;
  var cel = ''.obs;
  var whatsapp = ''.obs;
  var responsavel = ''.obs;
  var whatresp = ''.obs;
  var celresp = ''.obs;
  var niveresp = ''.obs;
  var status = ''.obs;
  var statuscliente = ''.obs;
  var observacao = ''.obs;
  var lat = ''.obs;
  var lng = ''.obs;
  var imgfachada = ''.obs;
  var isLoading = true.obs;

  void getclientes() {
    isLoading(true);
    ApiClientes.getClientes().then((response) {
      Iterable lista = json.decode(response.body);
      clientes.assignAll(
          lista.map((model) => Dadosclientes.fromJson(model)).toList());
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
