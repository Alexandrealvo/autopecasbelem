import 'package:apbelem/modules/Chamadas/status_controller.dart';
import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:apbelem/modules/Clientes/dadoscliente.dart';
import 'package:apbelem/modules/Clientes/dadosresponsavel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MudarStatus extends StatefulWidget {
  @override
  _MudarStatusState createState() => _MudarStatusState();
}

class _MudarStatusState extends State<MudarStatus> {
  StatusController statusController = Get.put(StatusController());
  ClientesController clientesController = Get.put(ClientesController());

  var texto = "";

  void dropDownFavoriteSelected(String novoItem) {
    statusController.firstId.value = novoItem;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 25),
                onPressed: () {
                  print(statusController.page.value);
                  if (statusController.page.value == 2) {
                    statusController.handleMinusPage();
                  } else if (statusController.page.value == 1) {
                    Navigator.of(context).pop();
                  }
                }),
            actions: [
              statusController.page.value == 2
                  ? Container()
                  : Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 25,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          onPressed: () {
                            print(statusController.page.value);
                            statusController.handleAddPage();
                          },
                        ),
                      ],
                    )
            ],
            title: statusController.page.value == 2
                ? Text(
                    'Editar Responsável',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
              ),
            )
                : Text(
                    'Editar Cliente',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
            centerTitle: true,
          ),
          body: Obx(() {
            return statusController.page.value == 1
                ? DadosCliente()
                : DadosResp();
          }),
        ),
      );
    });
  }
}

class DadosResponsavel {}
