import 'dart:async';
import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:apbelem/modules/Mapa/mapa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaCliente extends StatefulWidget {
  @override
  MapaClienteState createState() => MapaClienteState();
}

class MapaClienteState extends State<MapaCliente> {
  MapaController mapaController = Get.put(MapaController());
  ClientesController clientesController = Get.put(ClientesController());
  Completer<GoogleMapController> _controller = Completer();
  bool isLoading = true;
  BitmapDescriptor pinLocationIcon;

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/clientes.png');
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Localização Cliente',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return mapaController.isLoading.value
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                    child: Center(
                      child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                        ),
                        height: 40,
                        width: 40,
                      ),
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      _buildGoogleMap(context),
                      _buildContainer(),
                    ],
                  );
          },
        ));
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

  Widget _buildContainer() {
    return Positioned(
      bottom: 10,
      right: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: _boxes(
                    double.parse(clientesController.lat.value),
                    double.parse(clientesController.lng.value),
                    clientesController.nomecliente.value,
                    clientesController.endereco.value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxes(double lat, double long, String nome, String end) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          _gotoLocation(lat, long);
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
          initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(clientesController.lat.value),
                  double.parse(clientesController.lng.value)),
              zoom: 14),
          onMapCreated: (GoogleMapController controller) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {}
            changeMapMode();
          },
          markers: mapaController.markers,
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
}
