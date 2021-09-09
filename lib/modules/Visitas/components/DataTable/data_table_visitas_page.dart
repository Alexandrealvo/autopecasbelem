import 'package:apbelem/modules/Visitas/components/DataTable/data_table_visitas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTableVisitas extends StatelessWidget {
  final DataTableController dataTableController =
      Get.put(DataTableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: DataTable(
              sortColumnIndex: 0,
              sortAscending: true,
              columns: [
                DataColumn(
                  label: Text(
                    'Cliente',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Checkin',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Checkout',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Tempo total',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
              ],
              rows: dataTableController.data
                  .map(
                    (item) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            item['cliente'],
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ),
                        ),
                        DataCell(
                          Text(
                            item['checking'],
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ),
                        ),
                        DataCell(
                          Text(
                            item['checkout'],
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ),
                        ),
                        DataCell(
                          Text(
                            item['tempototal'],
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }
}
