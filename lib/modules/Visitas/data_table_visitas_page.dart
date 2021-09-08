import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTableVisitas extends StatelessWidget {
  const DataTableVisitas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTable(
              sortColumnIndex: 0,
              sortAscending: true,
              columns: [
                DataColumn(
                  label: Text(
                    'Name',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Age',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                ),
              ],
              rows: [
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text('Sarah',
                          style: GoogleFonts.montserrat(fontSize: 14)),
                    ),
                    DataCell(Text('19',
                        style: GoogleFonts.montserrat(fontSize: 14))),
                    DataCell(Text('Student',
                        style: GoogleFonts.montserrat(fontSize: 14))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Janine',
                        style: GoogleFonts.montserrat(fontSize: 14))),
                    DataCell(Text('43',
                        style: GoogleFonts.montserrat(fontSize: 14))),
                    DataCell(Text('Professor',
                        style: GoogleFonts.montserrat(fontSize: 14))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('William')),
                    DataCell(Text('27')),
                    DataCell(Text('Associate Professor')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
