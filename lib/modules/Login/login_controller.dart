import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var idusu = ''.obs;
  var nome = ''.obs;
  var imgperfil = ''.obs;
  var tipousu = ''.obs;
  var phone = ''.obs;
  var birthdate = ''.obs;
  var genero = ''.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var isLoading = false.obs;

  void onLoading() async {
    refreshController.loadComplete();
  }

  Future<void> launched;

  storageId() async {
    await GetStorage.init();
    final box = GetStorage();
    box.write('password', password.value.text);
    box.write('emailController', email.value.text);
  }

  login() async {
    isLoading(true);

    final response = await http.post(
        Uri.https("admautopecasbelem.com.br", '/login/flutter/login.php'),
        body: {
          "email": email.value.text,
          "senha": password.value.text,
        });
    isLoading(false);

    var dadosUsuario = json.decode(response.body);

    if (dadosUsuario['valida'] == 1) {
      return dadosUsuario;
    } else {
      return null;
    }
  }

  loginAuth(String senha, String email) async {
    isLoading(true);
    final response = await http.post(
        Uri.https("admautopecasbelem.com.br", '/login/flutter/login.php'),
        body: {
          "email": email,
          "senha": senha,
        });

    isLoading(false);

    var dadosUsuario = json.decode(response.body);

    if (dadosUsuario['valida'] == 1) {
      return dadosUsuario;
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
