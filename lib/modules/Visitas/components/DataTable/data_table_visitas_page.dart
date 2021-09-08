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
      body: Container(
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
          ],
          rows: [
            for (var i = 0; i < dataTableController.data.length; i++)
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text(dataTableController.data[i]['cliente'],
                        style: GoogleFonts.montserrat(fontSize: 14)),
                  ),
                  DataCell(Text('data.checking',
                      style: GoogleFonts.montserrat(fontSize: 14))),
                  DataCell(Text('data.checkout',
                      style: GoogleFonts.montserrat(fontSize: 14))),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
