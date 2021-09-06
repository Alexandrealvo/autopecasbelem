import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Comunicados extends StatelessWidget {
  //const Comunicados({ Key? key }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comunicados',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return comunicadosController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : Column(
                    children: [
                      boxSearch(
                          context,
                          comunicadosController.search.value,
                          comunicadosController.onSearchTextChanged,
                          "Pesquise os Comunicados..."),
                      Expanded(
                        child: _listacomunicados(),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }
}

