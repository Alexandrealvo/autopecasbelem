import 'package:apbelem/modules/Chamadas/status_controller.dart';
import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:apbelem/utils/alert_button_pressed.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:apbelem/utils/custom_text_field.dart';
import 'package:apbelem/utils/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DadosResp extends StatefulWidget {
  //const DadosResp({ Key? key }) : super(key: key);

  @override
  _DadosRespState createState() => _DadosRespState();
}

class _DadosRespState extends State<DadosResp> {
  StatusController statusController = Get.put(StatusController());
  ClientesController clientesController = Get.put(ClientesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return clientesController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(8),
                    //height: MediaQuery.of(context).size.height * .95,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        customTextField(
                          context,
                          'Nome Responsável',
                          null,
                          false,
                          1,
                          true,
                          statusController.nomeresp.value,
                          false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [statusController.cellMaskFormatter],
                          controller: statusController.celresp.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Celular Responsável',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [statusController.cellMaskFormatter],
                          controller: statusController.whatsresp.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Whatsapp Responsável',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            statusController.birthDateMaskFormatter
                          ],
                          controller: statusController.niveresp.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Data de Aniversário',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonTheme(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Theme.of(context).accentColor;
                                },
                              ),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>(
                                (Set<MaterialState> states) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  );
                                },
                              ),
                            ),
                            onPressed: () {
                              statusController.editarCliente().then((value) {
                                if (value == 1) {
                                  clientesController.getclientes();
                                  edgeAlertWidgetTop(
                                    context,
                                    'Dados do Cliente foram Atualizados com Sucesso!',
                                  );
                                } else if (value == "vazio") {
                                  onAlertButtonPressed(
                                      context, 'Algum Campo Vazio!', null);
                                } else {
                                  onAlertButtonPressed(
                                      context,
                                      'Algo deu errado\n Tente novamente',
                                      null);
                                }
                              });
                            },
                            child: Text(
                              "Editar",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonTheme(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Theme.of(context).errorColor;
                                },
                              ),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>(
                                (Set<MaterialState> states) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  );
                                },
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancelar",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
