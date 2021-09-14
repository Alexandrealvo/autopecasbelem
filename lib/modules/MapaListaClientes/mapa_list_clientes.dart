import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:apbelem/modules/Clientes/api_clientes.dart';
import 'package:apbelem/modules/Clientes/mapa_clientes.dart';
import 'package:apbelem/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:apbelem/utils/box_search.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class MapaListaClientes extends StatefulWidget {
  @override
  MapaListaClientesState createState() => MapaListaClientesState();
}

class MapaListaClientesState extends State<MapaListaClientes> {
  final MapaAgendaController mapaAgendaController =
      Get.put(MapaAgendaController());
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
                BitmapDescriptor.hueYellow,
              )));
        }

        isLoading = false;
      });
    });
  }

  clientesNum() {}

  var search = TextEditingController();
  var searchResult = [];
  double zoomVal = 5;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Localização Clientes',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                }),
          ],
        ),
        body: isLoading
            ? CircularProgressIndicatorWidget()
            : Stack(
                children: <Widget>[
                  _buildGoogleMap(context),
                  isSearching
                      ? boxSearch(context, search, onSearchTextChanged,
                          "Pesquise o Cliente")
                      : Container(),
                  _floatButtomMapa(),
                  _buildContainer(),
                ],
              ));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  changeMapMode() {
    getJsonFile("images/mapa_style.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) async {
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(mapStyle);
  }

  Widget _floatButtomMapa() {
    return Positioned(
      top: isSearching ? 80 : 10,
      right: 10,
      child: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          _gotoMyLocation(mapaAgendaController.ourLat.value,
              mapaAgendaController.ourLng.value);
        },
        child: Icon(
          Icons.my_location_outlined,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).errorColor,
        heroTag: 'call',
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 4.0,
          ),
        ),
        tooltip: 'Call',
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
              color: Theme.of(context).errorColor,
              elevation: 12.0,
              borderRadius: BorderRadius.circular(20.0),
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
              CameraPosition(target: LatLng(-1.4241198, -48.4647034), zoom: 14),
          onMapCreated: (GoogleMapController controller) async {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {}
            changeMapMode();

            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);

            mapaAgendaController.ourLat.value = position.latitude;
            mapaAgendaController.ourLng.value = position.longitude;

            LatLng latlngPosition =
                LatLng(position.latitude, position.longitude);

            controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: latlngPosition,
              zoom: 14,
            )));

            final Uint8List markerIconCliente =
                await getBytesFromAsset('images/iconUserMap.png', 90);

            if (this.mounted) {
              setState(() {
                _markers.add(
                  Marker(
                    markerId: MarkerId('Estou Aqui!'),
                    position: latlngPosition,
                    infoWindow: InfoWindow(
                      title: 'Minha Localização',
                      snippet: "",
                    ),
                    icon: BitmapDescriptor.fromBytes(markerIconCliente),
                  ),
                );
              });
            }
          },
          markers: _markers,
        ));
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 16,
      tilt: 40,
      bearing: 40,
    )));
  }

  Future<void> _gotoMyLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 18,
      tilt: 40,
      bearing: 40,
    )));
  }
}
