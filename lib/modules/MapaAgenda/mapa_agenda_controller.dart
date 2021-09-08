import 'dart:convert';

import 'package:apbelem/modules/MapaAgenda/mapa_agenda_repository.dart';
import 'package:apbelem/utils/alert_button_pressed.dart';
import 'package:apbelem/utils/confirmed_button_pressed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaAgendaController extends GetxController {
  var isLoading = true.obs;

  var lat = 0.0.obs;
  var lng = 0.0.obs;
  var ourLat = 0.0.obs;
  var ourLng = 0.0.obs;
  var name = ''.obs;
  var adress = ''.obs;
  var district = ''.obs;
  var city = ''.obs;
  var uf = ''.obs;
  var number = ''.obs;
  var ctlcheckin = ''.obs;
  var idVisita = ''.obs;
  var idCliente = ''.obs;

  var markers = <Marker>{}.obs;

  getClientes() async {
    markers.assign(
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

  doCheckIn(context) async {
    final response = await MapaAgendaRepository.doCheckin();

    var dados = json.decode(response.body);

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
          context, 'Algo deu errado, tente novamente', '/home');
    } else {
      confirmedButtonPressed(
          context, 'Check-in realizado com sucesso!', '/home');
    }
  }

  doCheckout(context) async {
    final response = await MapaAgendaRepository.doCheckin();

    var dados = json.decode(response.body);

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
          context, 'Algo deu errado, tente novamente', '/home');
    } else {
      confirmedButtonPressed(
          context, 'Check-out realizado com sucesso!', '/home');
    }
  }

  doChangeGps(context) async {
    final response = await MapaAgendaRepository.doChangeGps();

    var dados = json.decode(response.body);

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
          context, 'Algo deu errado, tente novamente', '/home');
    } else {
      confirmedButtonPressed(
          context, 'Alteração de GPS realizado com sucesso!', '/home');
    }
  }

  deleteClient(context) async {
    final response = await MapaAgendaRepository.deleteClient();

    var dados = json.decode(response.body);

    if (dados['valida'] == 0) {
      onAlertButtonPressed(
          context, 'Algo deu errado, tente novamente', '/home');
    } else {
      confirmedButtonPressed(context, 'Cliente deletado com sucesso!', '/home');
    }
  }
}
