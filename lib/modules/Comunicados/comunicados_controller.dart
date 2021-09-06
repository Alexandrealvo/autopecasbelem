
import 'package:get/get.dart';

class ClientesController extends GetxController {
  var clientes = <Dadoscomunicados>[].obs;
  var idcliente = ''.obs;
  var nomecliente = ''.obs;
  var datacliente = ''.obs;
  var endereco = ''.obs;
  
  var isLoading = true.obs;

  void getclientes() {
    isLoading(true);
    Api.getClientes().then((response) {
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
