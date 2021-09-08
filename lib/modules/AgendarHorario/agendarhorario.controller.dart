import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AgendaHorarioController extends GetxController {
  var isLoading = false.obs;
  var idvisita = ''.obs;
  var horaent = TextEditingController().obs;
  var horasai = TextEditingController().obs;

  var horaMaskFormatter = new MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
