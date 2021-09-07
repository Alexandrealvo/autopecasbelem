import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaAgendaController extends GetxController {
  var isLoading = true.obs;

  var lat = 0.0.obs;
  var lng = 0.0.obs;
  var name = ''.obs;
  var adress = ''.obs;
  var district = ''.obs;
  var city = ''.obs;
  var uf = ''.obs;
  var number = ''.obs;

  var markers = <Marker>{}.obs;

  getClientes() async {
    markers.add(
      Marker(
        markerId: MarkerId(name.value),
        position: LatLng(lat.value, lng.value),
        infoWindow: InfoWindow(
          title: name.value,
          snippet: "$adress",
        ),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'images/cliente.png'),
      ),
    );
    isLoading(false);
  }
}
