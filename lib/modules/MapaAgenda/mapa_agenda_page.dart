import 'dart:typed_data';

import 'package:apbelem/modules/MapaAgenda/mapa_agenda_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;

class MapaAgendaPage extends StatefulWidget {
  const MapaAgendaPage({Key key}) : super(key: key);

  @override
  _MapaAgendaPageState createState() => _MapaAgendaPageState();
}

class _MapaAgendaPageState extends State<MapaAgendaPage> {
  @override
  Widget build(BuildContext context) {
    MapaAgendaController mapaAgendaController = Get.put(MapaAgendaController());
    Completer<GoogleMapController> _controller = Completer();
    Color cor = Colors.yellow.withOpacity(0.3);

    Future<String> getJsonFile(String path) async {
      return await rootBundle.loadString(path);
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

    void setMapStyle(String mapStyle) async {
      final GoogleMapController controller = await _controller.future;
      controller.setMapStyle(mapStyle);
    }

    changeMapMode() {
      getJsonFile("images/mapa_style.json").then(setMapStyle);
    }

    void timer() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng latLatAtual = LatLng(position.latitude, position.longitude);

      Future.delayed(Duration(seconds: 2)).then((_) async {
        final Uint8List markerIconCliente =
            await getBytesFromAsset('images/iconUserMap.png', 90);
        if (this.mounted) {
          // check whether the state object is in tree
          setState(() {
            print('oaaa');
            mapaAgendaController.markers.add(Marker(
              markerId: MarkerId('Estou Aqui!'),
              position: latLatAtual,
              infoWindow: InfoWindow(
                  title: 'Minha Localização', snippet: "" //"$position",
                  ),
              icon: BitmapDescriptor.fromBytes(markerIconCliente),
            ));
          });
        }

        timer();
      });
    }

    Widget buildGoogleMap(BuildContext context) {
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
              target: LatLng(mapaAgendaController.lat.value,
                  mapaAgendaController.lng.value),
              zoom: 14),
          onMapCreated: (GoogleMapController controller) async {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {}
            changeMapMode();
            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);

            LatLng latLatPosition =
                LatLng(position.latitude, position.longitude);

            LatLng latLatCliente = LatLng(
                mapaAgendaController.lat.value, mapaAgendaController.lng.value);

            //condição para o reposicionamemto
            if (latLatPosition.latitude <= latLatCliente.latitude) {
              LatLngBounds bounds = LatLngBounds(
                southwest: latLatPosition,
                northeast: latLatCliente,
              );
              controller
                  .animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
            } else {
              LatLngBounds bounds = LatLngBounds(
                southwest: latLatCliente,
                northeast: latLatPosition,
              );
              controller
                  .animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
            }
            final Uint8List markerIconCliente =
                await getBytesFromAsset('images/iconUserMap.png', 90);

            if (this.mounted) {
              setState(() {
                mapaAgendaController.markers.add(
                  Marker(
                    markerId: MarkerId('Estou Aqui!'),
                    position: latLatPosition,
                    infoWindow: InfoWindow(
                      title: 'Minha Localização',
                      snippet: "",
                    ),
                    icon: BitmapDescriptor.fromBytes(markerIconCliente),
                  ),
                );
              });
            }
            timer();
          },
          circles: Set.from([
            Circle(
              circleId: CircleId('circle'),
              center: LatLng(mapaAgendaController.lat.value,
                  mapaAgendaController.lng.value),
              radius: 80,
              strokeColor: cor,
              fillColor: cor,
            )
          ]),
          markers: mapaAgendaController.markers,
        ),
      );
    }

    Future<void> gotoLocation(double lat, double long) async {
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, long),
            zoom: 16,
            tilt: 40,
            bearing: 40,
          ),
        ),
      );
    }

    Widget boxes(double lat, double long, String nome, String end) {
      return GestureDetector(
        onTap: () {
          gotoLocation(lat, long);
        },
        child: Container(
          child: new FittedBox(
            child: Material(
                color: Theme.of(context).buttonColor,
                elevation: 12,
                borderRadius: BorderRadius.circular(10),
                shadowColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        Icons.center_focus_weak,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      );
    }

    Widget buildContainer() {
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
                    child: boxes(
                      mapaAgendaController.lat.value,
                      mapaAgendaController.lng.value,
                      mapaAgendaController.name.value,
                      mapaAgendaController.adress.value,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          return mapaAgendaController.isLoading.value
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
                    buildGoogleMap(context),
                    buildContainer(),
                  ],
                );
        },
      ),
    );
  }
}
