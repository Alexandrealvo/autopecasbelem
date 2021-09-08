import 'dart:convert';
import 'package:apbelem/modules/Visitas/components/DataTable/data_table_visitas_controller.dart';
import 'package:apbelem/modules/Visitas/components/DataTable/data_table_visitas_model.dart';
import 'package:apbelem/modules/Visitas/visitas_repository.dart';
import 'package:get/get.dart';

class VisitasController extends GetxController {
  DataTableController dataTableController = Get.put(DataTableController());

  var clientes = [].obs;
  var initialDate = ''.obs;
  var finalDate = ''.obs;
  var firstId = '0'.obs;
  var isLoading = false.obs;

  getVisitantes() async {
    isLoading(true);

    final response = await VisitasRepository.getVisitantes();

    var dados = json.decode(response.body);

    clientes.assignAll(dados);

    isLoading(false);
  }

  doRelatorios() async {
    isLoading(true);

    final response = await VisitasRepository.doRelatorios();

    print(json.decode(response.body));

    var dados = json.decode(response.body);

    dataTableController.data.assignAll(dados);

    Get.toNamed('/dataTableVisitas');

    dataTableController.isLoading(false);

    isLoading(false);
  }

  @override
  void onInit() {
    getVisitantes();
    super.onInit();
  }
}
