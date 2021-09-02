import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:apbelem/modules/Agenda/api_agenda.dart';
import 'package:apbelem/modules/Agenda/mapa_agenda.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaController extends GetxController {
  var isLoading = true.obs;
  var onSelected = false.obs;
  var periodo = TextEditingController().obs;
  var dias = ''.obs;
  var checkeddom = false.obs;
  var checkedseg = false.obs;
  var checkedter = false.obs;
  var checkedqua = false.obs;
  var checkedqui = false.obs;
  var checkedsex = false.obs;
  var checkedsab = false.obs;

  var firstId = '0'.obs;
  var itemSelecionado = 'Selecione Qtd de'.obs;

  List<String> tipos = [
    'Selecione Qtd de',
    '1',
    '2',
    '4',
    '12',
  ];

  List<String> itens = [
    'Domingo',
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
  ];

  getAgendarVisitas() async {
    List<int> diasArray = [];

    if (checkeddom.value == true) {
      diasArray = diasArray + [0];
    }
    if (checkedseg.value == true) {
      diasArray = diasArray + [1];
    }
    if (checkedter.value == true) {
      diasArray = diasArray + [2];
    }
    if (checkedqua.value == true) {
      diasArray = diasArray + [3];
    }
    if (checkedqui.value == true) {
      diasArray = diasArray + [4];
    }
    if (checkedsex.value == true) {
      diasArray = diasArray + [5];
    }
    if (checkedsab.value == true) {
      diasArray = diasArray + [6];
    }

    print(diasArray);

    if (itemSelecionado.value == 'Selecione Qtd de') {
      return 'vazio';
    } else {
      isLoading(true);
      var response = await ApiAgendar.agendarVisitas();
      var dados = json.decode(response.body);

      isLoading(false);

      return dados;
    }
  }

  @override
  void onInit() {
    // init();
    // agendaReservas();
    super.onInit();

    isLoading(false);
  }
}
