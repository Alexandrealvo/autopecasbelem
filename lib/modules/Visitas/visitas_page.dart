import 'package:apbelem/modules/Visitas/visitas_controller.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:apbelem/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class VisitasPage extends StatefulWidget {
  @override
  _VisitasPageState createState() => _VisitasPageState();
}

class _VisitasPageState extends State<VisitasPage> {
  final VisitasController visitasController = Get.put(VisitasController());

  void dropDownClientsSelected(String novoItem) {
    visitasController.firstId.value = novoItem;
  }

  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();
  var endSelectedDate = DateTime.now();
  var endSelectedTime = TimeOfDay.now();
  var startTime = TextEditingController();
  var endTime = TextEditingController();

  Future<TimeOfDay> selectTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child);
      },
    );
  }

  Future<TimeOfDay> selectEndTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 59),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visitas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return visitasController.isLoading.value
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context).primaryColor;
                                  },
                                ),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                  (Set<MaterialState> states) {
                                    return 0;
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
                              onPressed: () {},
                              child: DropdownButton<String>(
                                autofocus: false,
                                isExpanded: true,
                                underline: Container(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 27,
                                ),
                                dropdownColor: Theme.of(context).primaryColor,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                                items: visitasController.clientes.map((item) {
                                  return DropdownMenuItem(
                                    value: item['idcliente'].toString(),
                                    child: Text(item['nomecliente']),
                                  );
                                }).toList(),
                                onChanged: (String novoItemSelecionado) {
                                  dropDownClientsSelected(novoItemSelecionado);
                                  visitasController.firstId.value =
                                      novoItemSelecionado;
                                },
                                value: visitasController.firstId.value,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 8,
                          ),
                          child: Text(
                            'Data Inicial: ',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                        ),
                        
                        Container(
                          child: GestureDetector(
                            onTap: () async {
                              startSelectedTime = await selectTime(context);
                              if (startSelectedTime == null) return;

                              setState(() {
                                startSelectedDate = DateTime(
                                  startSelectedDate.year,
                                  startSelectedDate.month,
                                  startSelectedDate.day,
                                  startSelectedTime.hour,
                                  startSelectedTime.minute,
                                );
                              });
                            },
                            child: customTextField(
                              context,
                              null,
                              DateFormat("HH:mm").format(
                                startSelectedDate,
                              ),
                              false,
                              1,
                              false,
                              startTime,
                              false,
                            ),
                          ),
                        ),
                         SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 8,
                          ),
                          child: Text(
                            'Data Final: ',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () async {
                              endSelectedTime = await selectEndTime(context);
                              if (endSelectedTime == null) return;

                              setState(() {
                                endSelectedDate = DateTime(
                                  endSelectedDate.year,
                                  endSelectedDate.month,
                                  endSelectedDate.day,
                                  endSelectedTime.hour,
                                  endSelectedTime.minute,
                                );
                              });
                            },
                            child: customTextField(
                              context,
                              null,
                              DateFormat("HH:mm").format(
                                endSelectedDate,
                              ),
                              false,
                              1,
                              false,
                              endTime,
                              false,
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
                            onPressed: () async {
                              visitasController.initialDate.value =
                                  DateFormat("HH:mm").format(
                                startSelectedDate,
                              );
                              visitasController.finalDate.value =
                                  DateFormat("HH:mm").format(
                                endSelectedDate,
                              );

                              await visitasController.doRelatorios();
                            },
                            child: Text(
                              "Enviar",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
