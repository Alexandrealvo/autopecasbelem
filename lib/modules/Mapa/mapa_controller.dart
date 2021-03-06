import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaController extends GetxController {
  ClientesController clientesController = Get.put(ClientesController());

  var isLoading = true.obs;
  var markers = <Marker>{}.obs;

  getClientes() async {
    markers.add(
      Marker(
        markerId: MarkerId(clientesController.nomecliente.value),
        position: LatLng(double.parse(clientesController.lat.value),
            double.parse(clientesController.lng.value)),
        infoWindow: InfoWindow(
          title: clientesController.nomecliente.value,
          snippet: "${clientesController.endereco.value}",
        ),
         icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueYellow,
        )));
  
    print(markers);
    isLoading(false);
  }

  @override
  void onInit() {
    getClientes();
    super.onInit();
  }
}
