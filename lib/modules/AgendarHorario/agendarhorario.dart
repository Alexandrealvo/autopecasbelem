import 'package:apbelem/modules/AgendarHorario/agendarhorario.controller.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AgendarHorario extends StatelessWidget {
  //const AgendarHorario({ Key? key }) : super(key: key);
  AgendaHorarioController agendahorarioController =
      Get.put(AgendaHorarioController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Agendar Horário',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return agendahorarioController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height * .95,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              agendahorarioController.HoraMaskFormatter
                            ],
                            controller: agendahorarioController.horaent.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
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
                              labelText: 'Hora Entrada',
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 14,
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

                         SizedBox(height: 15),
TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              agendahorarioController.HoraMaskFormatter
                            ],
                            controller:agendahorarioController.horaent.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
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
                              labelText: 'Hora Entrada',
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 14,
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
                            height: 30,
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
                                /* print(agendaController.idcliente.value);
                                agendaController
                                    .getAgendarVisitas()
                                    .then((value) {
                                  if (value == 1) {
                                    print('teste');
                                    edgeAlertWidgetTop(
                                      context,
                                      'Agendamento Realizado com Sucesso!',
                                    );
                                    Get.offNamed('/visualizar_agenda');
                                    // Get.toNamed('/visualizar_agenda');
                                  } else if (value == "qtdvazio") {
                                    edgeAlertWidgetDangerTop(
                                        context, 'Selecione Qtd de Semanas!');
                                  } else if (value == "diasvazio") {
                                    edgeAlertWidgetDangerTop(context,
                                        'Selecione pelo menos um dia da semana!');
                                  } else {
                                    onAlertButtonPressed(
                                        context,
                                        'Algo deu errado\n Tente novamente',
                                        null);
                                  }
                                });*/
                              },
                              child: Text(
                                "Incluir Horário",
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
                  );
          })),
    );
  }
}
