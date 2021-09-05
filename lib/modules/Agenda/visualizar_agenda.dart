import 'package:apbelem/modules/Agenda/calendario_controller.dart';
import 'package:apbelem/modules/Agenda/mapa_calendario.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class VisualizarAgenda extends StatelessWidget {
  //const VisualizarAgenda ({ Key? key }) : super(key: key);
  CalendarioController calendarioController = Get.put(CalendarioController());

  Widget buildEventsMarker(context, DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSameDay(calendarioController.selectedDay.value, date)
            ? Theme.of(context).buttonColor
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
                          firstDay: DateTime(2019),
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
                              borderRadius: BorderRadius.circular(5.0),
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
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.green,
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
                                      text: '${e.endereco} - hora: ${e.bairro}',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            onTap: () {
                              /* detalhesReservasController.idEve.value =
                                            e.idevento;
                                        detalhesReservasController
                                            .validaUsu.value = e.validausu;

                                        detalhesReservasController.goToDetails(
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
