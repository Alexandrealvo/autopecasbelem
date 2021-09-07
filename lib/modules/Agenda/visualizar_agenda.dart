import 'package:apbelem/modules/Agenda/calendario_controller.dart';
import 'package:apbelem/modules/Agenda/mapa_calendario.dart';
import 'package:apbelem/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class VisualizarAgenda extends StatelessWidget {
  final CalendarioController calendarioController =
      Get.put(CalendarioController());
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());
  //const VisualizarAgenda ({ Key? key }) : super(key: key);

  Widget buildEventsMarker(context, DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSameDay(calendarioController.selectedDay.value, date)
            ? Colors.blue[800]
            : Theme.of(context).accentColor,
      ),
      width: 18.0,
      height: 18.0,
      child: Center(
        child: Text('${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 14.0,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var lastday = today.add(const Duration(days: 90));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        centerTitle: true,
      ),
      /* floatingActionButton: Obx(() {
        return calendarioController.onSelected.value == true &&
                reservasController.multi.value == 'S' &&
                calendarioController.selectedDay.value
                    .isAfter(calendarioController.day)
            ? FloatingActionButton(
                onPressed: () {
                  Get.toNamed('/addReservas');
                },
                child: Icon(Icons.add),
              )
            : Container();
      }),*/
      body: Obx(
        () {
          return calendarioController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TableCalendar(
                          locale: 'pt_BR',
                          firstDay: DateTime.utc(2021, 08, 01),
                          lastDay: lastday, //DateTime(2030),
                          focusedDay: calendarioController.focusedDay.value,
                          availableGestures: AvailableGestures.all,
                          startingDayOfWeek: StartingDayOfWeek.sunday,
                          eventLoader: calendarioController.getEventsfromDay,
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            formatButtonShowsNext: false,
                            formatButtonDecoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            formatButtonTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, date, events) {
                              if (events.isNotEmpty) {
                                return Positioned(
                                  right: 4,
                                  top: 2,
                                  child:
                                      buildEventsMarker(context, date, events),
                                );
                              }
                              return Container();
                            },
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            weekendStyle: TextStyle(
                              color: Colors.amber,

                              /*Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,*/
                            ),
                          ),
                          calendarStyle: CalendarStyle(
                            outsideDaysVisible: true,
                            todayDecoration: BoxDecoration(
                              color: Theme.of(context).buttonColor,
                              shape: BoxShape.circle,
                            ),
                            defaultTextStyle: TextStyle(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            weekendTextStyle: TextStyle(
                              color: Colors.amber,
                            ),
                            holidayTextStyle: TextStyle(
                              color: Colors.green,
                            ),
                            selectedTextStyle: TextStyle(
                              color: Colors.black,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                          ),
                          calendarFormat: calendarioController.calendarFormat,
                          onDaySelected: (selectedDay, focusedDay) {
                            calendarioController.onSelected.value = true;

                            if (!isSameDay(selectedDay,
                                calendarioController.selectedDay.value)) {
                              calendarioController.selectedDay.value =
                                  selectedDay;
                              calendarioController.focusedDay.value =
                                  focusedDay;
                            }

                            if (calendarioController.events[calendarioController
                                        .selectedDay.value] ==
                                    null &&
                                calendarioController.selectedDay.value
                                    .isAfter(calendarioController.day)) {
                              // Get.toNamed('/addReservas');
                            }
                          },
                          selectedDayPredicate: (DateTime date) {
                            return isSameDay(
                                calendarioController.selectedDay.value, date);
                          },
                        ),
                      ),
                      ...calendarioController
                          .getEventsfromDay(
                        calendarioController.selectedDay.value,
                      )
                          .map((MapaEvento e) {
                        print(e.infocheckin);
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: (e.ctlcheckin == "0" &&
                                        e.ctlcheckout == "0") &&
                                    (e.infocheckin == "0" &&
                                        e.infocheckout == "0")
                                ? Theme.of(context).buttonColor
                                : (e.ctlcheckin == "1" &&
                                            e.ctlcheckout == "0") &&
                                        (e.infocheckin == "0" &&
                                            e.infocheckout == "0")
                                    ? Colors.red[400]
                                    : (e.ctlcheckin == "1" &&
                                                e.ctlcheckout == "1") &&
                                            (e.infocheckin == "0" &&
                                                e.infocheckout == "0")
                                        ? Colors.green[400]
                                        : (e.ctlcheckin == "1" &&
                                                    e.ctlcheckout == "1") &&
                                                (e.infocheckin == "1" &&
                                                    e.infocheckout == "0")
                                            ? Colors.blue[400]
                                            : (e.ctlcheckin == "1" &&
                                                        e.ctlcheckout == "1") &&
                                                    (e.infocheckin == "1" &&
                                                        e.infocheckout == "1")
                                                ? Colors.grey
                                                : Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: ListTile(
                            trailing: Icon(
                              Icons.arrow_right_outlined,
                              color: Colors.black,
                            ),
                            title: Text(
                              e.fantasia,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, color: Colors.black87),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${e.endereco}, ${e.numero} - ${e.bairro}',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            onTap: () {
                              var latLng = e.latlng.split(',');
                              var lat = double.parse(latLng[0]);
                              var lng = double.parse(latLng[1]);

                              mapaAgendaController.lat.value = lat;
                              mapaAgendaController.lng.value = lng;
                              mapaAgendaController.name.value = e.fantasia;
                              mapaAgendaController.adress.value = e.endereco;
                              mapaAgendaController.district.value = e.bairro;
                              mapaAgendaController.uf.value = e.uf;
                              mapaAgendaController.city.value = e.cidade;
                              mapaAgendaController.number.value = e.numero;

                              var temp = DateTime.now().toUtc();
                              var d1 =
                                  DateTime.utc(temp.year, temp.month, temp.day);

                              var data = DateTime.parse(e.dtagenda);
                              var d2 =
                                  DateTime.utc(data.year, data.month, data.day);

                              if ((e.ctlcheckin == '0' ||
                                      e.ctlcheckout == '0') &&
                                  (d2.compareTo(d1) == 0)) {
                                mapaAgendaController.getClientes();
                                Get.toNamed('/mapaAgenda');
                              } else if ((e.ctlcheckin != '1' ||
                                      e.ctlcheckout != '1') &&
                                  d2.compareTo(d1) > 0) {
                                
                                Get.toNamed('/agendarhorario');
                              } else if ((d2.compareTo(d1) < 0) &&
                                  (e.ctlcheckin == '0' ||
                                      e.ctlcheckout == '0')) {
                                print('abre page infocheck');
                              } else if (d2.compareTo(d1) < 0 &&
                                  (e.ctlcheckin == '1' &&
                                      e.ctlcheckout == '1')) {
                                print('abre page info visita');
                              } else {
                                print('abre page info visita');
                              }

                              //detalhesReservasController.idEve.value = e.idevento;
                              //detalhesReservasController.validaUsu.value = e.validausu;

                              /* mapacalendarioController.goToDetails(
                                          e.nome,
                                          e.unidade,
                                          e.titulo,
                                          e.dataAgenda,
                                          e.areacom,
                                          e.status,
                                          e.horaAgenda,
                                          e.respevent,
                                        );*/
                            },
                          ),
                        );

                        /*Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: e.status == 'Aprovado'
                                ? Colors.green[400]
                                : e.status == 'Recusado'
                                    ? Colors.red[300]
                                    : Colors.amber,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: ListTile(
                            trailing: Icon(
                              Icons.arrow_right_outlined,
                              color: Colors.black,
                            ),
                            title: Text(
                              e.nome,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${e.unidade} - ${e.horaAgenda}h',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            onTap: () {
                              detalhesReservasController.idEve.value =
                                  e.idevento;
                              detalhesReservasController.validaUsu.value =
                                  e.validausu;

                              print(e.areacom);

                              detalhesReservasController.goToDetails(
                                e.nome,
                                e.unidade,
                                e.titulo,
                                e.dataAgenda,
                                e.areacom,
                                e.status,
                                e.horaAgenda,
                                e.respevent,
                              );
                            },
                          ),
                        );*/
                      }),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
