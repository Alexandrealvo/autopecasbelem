import 'dart:convert';
import 'package:apbelem/modules/Chamadas/api_chamadas.dart';
import 'package:apbelem/modules/Chamadas/mapa_chamadas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarChamadasController extends GetxController {
  var chamadas = <Dadoschamadas>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var fav = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getChamadas();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    print('loading');
    refreshController.loadComplete();
  }

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    chamadas.forEach((details) {
      if (details.nomecliente.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  void getChamadas() {
    isLoading(true);

    ApiChamadas.getChamadas().then((response) {
      Iterable lista = json.decode(response.body);
      print(lista);
      chamadas.assignAll(
        lista.map((model) => Dadoschamadas.fromJson(model)).toList(),
      );
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getChamadas();
  }
}
