import 'package:apbelem/modules/Chamadas/chamadas_controller.dart';
import 'package:apbelem/modules/Chamadas/status_controller.dart';
import 'package:apbelem/utils/alert_button_check.dart';
import 'package:apbelem/utils/alert_button_pressed.dart';
import 'package:apbelem/utils/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MudarStatus extends StatefulWidget {
  @override
  _MudarStatusState createState() => _MudarStatusState();
}

class _MudarStatusState extends State<MudarStatus> {
  StatusController statusController = Get.put(StatusController());
  ChamadasController chamadasController = Get.put(ChamadasController());

  var texto = "";

  void dropDownFavoriteSelected(String novoItem) {
    statusController.firstId.value = novoItem;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Alterar Status Cliente',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() => Container(
              margin: EdgeInsets.only(top: 100),
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        width: 1,
                      ),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 27,
                      ),
                      iconEnabledColor:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                      items: statusController.tipos
                          .map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String novoItemSelecionado) {
                        dropDownFavoriteSelected(novoItemSelecionado);
                        statusController.itemSelecionado.value =
                            novoItemSelecionado;
                      },
                      value: statusController.itemSelecionado.value,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: customTextField(
                      context,
                      "Faça uma observação...",
                      chamadasController.observacao.value,
                      true,
                      4,
                      true,
                      statusController.observacao.value,
                      true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonTheme(
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Theme.of(context).accentColor;
                            },
                          ),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              );
                            },
                          ),
                        ),
                        onPressed: () {
                          statusController
                              .getStatusCliente(
                                  chamadasController.idchamada.value,
                                  statusController.itemSelecionado.value)
                              .then((value) {
                            print(value);
                            if (value == 1) {
                              chamadasController.getChamadas();
                              onAlertButtonCheck(
                                context,
                                'Status Alterado com Sucesso!',
                                null,
                              );
                            } else if (value == "vazio") {
                              onAlertButtonPressed(
                                  context, 'Algum Campo Vazio!', null);
                            } else {
                              onAlertButtonPressed(context,
                                  'Algo deu errado\n Tente novamente', null);
                            }
                          });
                        },
                        child: Text(
                          "Alterar",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
