import 'dart:convert';
import 'package:apbelem/modules/Clientes/api_clientes.dart';
import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class StatusController extends GetxController {
  ClientesController clientesController = Get.put(ClientesController());

  var firstId = '0'.obs;
  var isLoading = true.obs;
  var observacao = TextEditingController().obs;
  var fantasia = TextEditingController().obs;
  var end = TextEditingController().obs;
  var numero = TextEditingController().obs;
  var bairro = TextEditingController().obs;
  var cep = TextEditingController().obs;
  var cidade = TextEditingController().obs;
  var uf = TextEditingController().obs;
  var telefone = TextEditingController().obs;
  var celular = TextEditingController().obs;
  var whats = TextEditingController().obs;
  var nomeresp = TextEditingController().obs;
  var celresp = TextEditingController().obs;
  var whatsresp = TextEditingController().obs;
  var niveresp = TextEditingController().obs;
  var status = TextEditingController().obs;
  var page = 1.obs;
  var imgfachada = ''.obs;
  var newDate = ''.obs;
  var itemSelecionado = "SELECIONE O STATUS".obs;

  List<String> tipos = [
    'SELECIONE O STATUS',
    'ABERTO',
    'FECHADO TEMPORARIAMENTE',
    'FECHADO',
    'EM REFORMA',
  ];

  var cellMaskFormatter = new MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  var cepMaskFormatter = new MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

 var telMaskFormatter = new MaskTextInputFormatter(
    mask: '(##) ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  var birthDateMaskFormatter = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var emailMaskFormatter = new MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  handleAddPage() {
    page.value = 2;
  }

  handleMinusPage() {
    page.value = 1;
  }

  editarCliente() async {
    if (fantasia.value.text == '' ||
        end.value.text == '' ||
        bairro.value.text == '' ||
        cidade.value.text == '' ||
        uf.value.text == '' ||
        fantasia.value.text == '' ||
        nomeresp.value.text == '' ||
        itemSelecionado.value == "SELECIONE O STATUS") {
      return 'vazio';
    } else {
      print(fantasia.value.text);
      isLoading(true);

      clientesController.statuscliente.value = itemSelecionado.value;
      clientesController.nomecliente.value = fantasia.value.text;
      clientesController.end.value = end.value.text;
      clientesController.numero.value = numero.value.text;
      clientesController.bairro.value = bairro.value.text;
      clientesController.cidade.value = cidade.value.text;
      clientesController.uf.value = uf.value.text;
      clientesController.cep.value = cep.value.text;
      clientesController.responsavel.value = nomeresp.value.text;
      clientesController.whatresp.value = whatsresp.value.text;
      clientesController.celresp.value = celresp.value.text;
      clientesController.status.value = status.value.text;
      clientesController.whatsapp.value = whats.value.text;
      clientesController.tel.value = telefone.value.text;
      clientesController.cel.value = celular.value.text;
      clientesController.imgfachada.value = imgfachada.value;
      clientesController.observacao.value = observacao.value.text;

      var date = niveresp.value.text.split('/');
      newDate.value = '${date[2]}-${date[1]}-${date[0]}';

      var response = await ApiClientes.editCliente();
      var dados = json.decode(response.body);

      isLoading(false);

      clientesController.niveresp.value = '${date[0]}-${date[1]}-${date[2]}';
      print(clientesController.niveresp.value);
      return dados;
    }
  }

  init() {
    itemSelecionado.value = clientesController.statuscliente.value;
    fantasia.value.text = clientesController.nomecliente.value;
    end.value.text = clientesController.end.value;
    numero.value.text = clientesController.numero.value;
    bairro.value.text = clientesController.bairro.value;
    cidade.value.text = clientesController.cidade.value;
    uf.value.text = clientesController.uf.value;
    cep.value.text = clientesController.cep.value;
    nomeresp.value.text = clientesController.responsavel.value;
    whatsresp.value.text = clientesController.whatresp.value;
    celresp.value.text = clientesController.celresp.value;
    var date =
        clientesController.niveresp.value.replaceAll('-', '/').split('/');
    niveresp.value.text = '${date[2]}/${date[1]}/${date[0]}';

    status.value.text = clientesController.statuscliente.value;
    whats.value.text = clientesController.whatsapp.value;
    telefone.value.text = clientesController.tel.value;
    celular.value.text = clientesController.cel.value;
    imgfachada.value = clientesController.imgfachada.value;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
