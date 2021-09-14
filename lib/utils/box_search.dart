import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

Widget boxSearch(
  BuildContext context,
  TextEditingController searchController,
  onSearchTextChanged,
  textopesquisa
) {
  return Container(
    padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
    child: TextField(
      onChanged: onSearchTextChanged == '' ? null : onSearchTextChanged,
      controller: searchController,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: Theme.of(context).buttonColor,
      ),
    
      decoration: InputDecoration(
        labelText: textopesquisa,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).buttonColor,
        ),
        prefixIcon: Icon(
          Feather.search,
          color: Theme.of(context).buttonColor,
          size: 20,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).buttonColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
