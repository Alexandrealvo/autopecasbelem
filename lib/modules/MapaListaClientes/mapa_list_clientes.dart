import 'dart:async';
import 'dart:convert';
import 'package:apbelem/modules/Clientes/api_clientes.dart';
import 'package:apbelem/modules/Clientes/mapa_clientes.dart';
import 'package:apbelem/utils/box_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapaListaClientes extends StatefulWidget {
  @override
  MapaListaClientesState createState() => MapaListaClientesState();
}

class MapaListaClientesState extends State<MapaListaClientes> {
  Completer<GoogleMapController> _controller = Completer();
  List<Dadosclientes> clientes = <Dadosclientes>[];
  bool isLoading = true;
  bool isSearching = false;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getClientes();
    clientesNum();
  }

  _getClientes() {
    ApiClientes.getClientes().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        print(lista);
        clientes = lista.map((model) => Dadosclientes.fromJson(model)).toList();
        for (var i = 0; i < clientes.length; i++) {
          _markers.add(Marker(
              markerId: MarkerId(clientes[i].nomecliente),
              position: LatLng(
                  double.parse(clientes[i].lat), double.parse(clientes[i].lng)),
              infoWindow: InfoWindow(
                title: clientes[i].nomecliente,
                snippet: clientes[i].endereco,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              )));
        }
        isLoading = false;
      });
    });
  }

  clientesNum() {}

  var search = TextEditingController();
  var searchResult = [];

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    clientes.forEach((details) {
      if (details.nomecliente.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
      setState(() {});
    });
  }

  double zoomVal = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa Lista Clientes',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search, size: 20),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              }),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                _buildGoogleMap(context),
                isSearching
                    ? boxSearch(context, search, onSearchTextChanged,
                        "Pesquise o Cliente")
                    : Container(),
                _buildContainer(),
              ],
            ),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: searchResult.isNotEmpty || search.value.text.isNotEmpty
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: searchResult.length,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      SizedBox(width: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _boxes(
                            double.parse(searchResult[i].lat),
                            double.parse(searchResult[i].lng),
                            searchResult[i].nomecliente,
                            searchResult[i].endereco),
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: clientes.length,
                itemBuilder: (context, i) {
                  return Row(
                    children: [
                      SizedBox(width: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _boxes(
                          double.parse(clientes[i].lat),
                          double.parse(clientes[i].lng),
                          clientes[i].nomecliente,
                          clientes[i].endereco,
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Widget _boxes(double lat, double long, String nome, String end) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.red[900],
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(nome, end),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String nome, end) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Container(
              child: Text(
            nome,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          end,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        )),
        SizedBox(height: 5.0),
      ],
    );
  }

  changeMapMode() {
    getJsonFile("images/mapa.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) async {
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(mapStyle);
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          compassEnabled: true,
          rotateGesturesEnabled: true,
          mapToolbarEnabled: true,
          tiltGesturesEnabled: true,
          initialCameraPosition:
              CameraPosition(target: LatLng(-1.4241198, -48.4647034), zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {}
            changeMapMode();
          },
          markers: _markers,
        ));
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 16,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
