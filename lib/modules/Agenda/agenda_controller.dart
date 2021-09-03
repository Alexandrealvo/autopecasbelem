import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:apbelem/modules/Agenda/api_agenda.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AgendaController extends GetxController {
  var isLoading = true.obs;
  var onSelected = false.obs;
  var periodo = TextEditingController().obs;
  var diasArray = [].obs;
  var checkeddom = false.obs;
  var checkedseg = false.obs;
  var checkedter = false.obs;
  var checkedqua = false.obs;
  var checkedqui = false.obs;
  var checkedsex = false.obs;
  var checkedsab = false.obs;
  var idcliente = ''.obs;
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

    //print("dias: ${diasArray[0]}");

    if (itemSelecionado.value == 'Selecione Qtd de' || diasArray[0] == "") {
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
