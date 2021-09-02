import 'dart:convert';
import 'package:apbelem/modules/Clientes/api_clientes.dart';
import 'package:apbelem/modules/Clientes/mapa_clientes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarClientesController extends GetxController {
  var clientes = <Dadosclientes>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var fav = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getClientes();
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
    clientes.forEach((details) {
      if (details.nomecliente.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  void getClientes() {
    isLoading(true);

    ApiClientes.getClientes().then((response) {
      Iterable lista = json.decode(response.body);
      print(lista);
      clientes.assignAll(
        lista.map((model) => Dadosclientes.fromJson(model)).toList(),
      );
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getClientes();
  }
}
