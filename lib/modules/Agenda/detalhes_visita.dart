import 'package:apbelem/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:apbelem/utils/custom_text_field.dart';
import 'package:apbelem/utils/get_date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesVisita extends StatelessWidget {
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detalhes Visita',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * .95,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.business_sharp,
                    size: 35,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Text(
                    mapaAgendaController.name.value,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Text(
                    "${mapaAgendaController.adress.value} ${mapaAgendaController.number.value} - ${mapaAgendaController.district.value}",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  )),
                  Center(
                      child: Text(
                    "${mapaAgendaController.city.value} - ${mapaAgendaController.uf.value}",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  )),
                  Divider(
                    height: 40,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Theme.of(context).buttonColor,
                  ),
                  Center(
                    child: Text(
                      'Check-in realizado em:',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Text(
                          getDateFormat(mapaAgendaController.checkin.value),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 40,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Theme.of(context).buttonColor,
                  ),
                  mapaAgendaController.checkout.value != '0000-00-00 00:00:00'
                      ? Column(
                          children: [
                     Center(
                    child: Text(
                      'Check-out realizado em:',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                       
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Center(
                        child: Text(
                            getDateFormat(mapaAgendaController.checkout.value),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                    
                    ],
                            ),
                            Divider(
                    height: 40,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Theme.of(context).buttonColor,
                  ),
                          ],
                        )
                      : Container(),
                  
                  
                  Container(
                    padding: EdgeInsets.all(15),
                    child: customTextField(
                      context,
                      "Faça uma Observação...",
                      mapaAgendaController.obs.value,
                      true,
                      3,
                      true,
                      mapaAgendaController.observacao.value,
                      true,
                    ),
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
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          },
                        ),
                      ),
                      onPressed: () async {
                        await mapaAgendaController.doObs(context);
                      },
                      child: Text(
                        "Enviar Observação",
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
        }));
  }

 
}
