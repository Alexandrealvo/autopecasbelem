import 'package:apbelem/modules/Chamadas/status_controller.dart';
import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApiClientes extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getClientes();
    refreshController.refreshCompleted();
  }

  static Future getClientes() async {
    LoginController loginController = Get.put(LoginController());
    print(loginController.idusu.value);

    return await http.get(Uri.https("www.admautopecasbelem.com.br",
        "/login/flutter/clientes.php", {"idusu": loginController.idusu.value}));
  }

  static Future editCliente() async {
    ClientesController clientesController = Get.put(ClientesController());
    LoginController loginController = Get.put(LoginController());
    StatusController statusController = Get.put(StatusController());

    print("idcliente: ${clientesController.idcliente.value}");
    print("niveresp: ${statusController.newDate.value}");

    return await http.post(
        Uri.https("www.admautopecasbelem.com.br",
            "/login/flutter/clientes_alterar.php"),
        body: {
          'idusu': loginController.idusu.value,
          'idcliente': clientesController.idcliente.value,
          'fantasia': clientesController.nomecliente.value,
          'end': clientesController.end.value,
          'numero': clientesController.numero.value,
          'bairro': clientesController.bairro.value,
          'cidade': clientesController.cidade.value,
          'uf': clientesController.uf.value,
          'cep': clientesController.cep.value,
          'responsavel': clientesController.responsavel.value,
          'whatresp': clientesController.whatresp.value,
          'celresp': clientesController.celresp.value,
          'niveresp': statusController.newDate.value,
          'status': clientesController.statuscliente.value,
          'whatsapp': clientesController.whatsapp.value,
          'tel': clientesController.tel.value,
          'cel': clientesController.cel.value,
          'imgfachada': clientesController.imgfachada.value,
          'obs': clientesController.observacao.value,
        });
        
  }

  @override
  void onInit() {
    super.onInit();
    getClientes();
  }
}
