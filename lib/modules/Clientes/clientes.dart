import 'package:apbelem/modules/Agenda/agenda_controller.dart';
import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:apbelem/modules/Clientes/visualizar_clientes_controller.dart';
import 'package:apbelem/utils/box_search.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:apbelem/utils/edge_alert_danger.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class Clientes extends StatefulWidget {
  @override
  _ClientesState createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  final ClientesController clientesController =
      Get.put(ClientesController(), permanent: true);
  VisualizarClientesController visualizarClientesController =
      Get.put(VisualizarClientesController());
  AgendaController agendaController = Get.put(AgendaController());

  @override
  void initState() {
    super.initState();
    clientesController.getclientes();
  }

  Future<void> _makePhoneCall(String cel) async {
    var celular = cel
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll(" ", "");

    var celFinal = "tel:$celular";

    if (await canLaunch(celFinal)) {
      await launch(celFinal);
    } else {
      EdgeAlert.show(context,
          title: 'Erro! Não foi possível ligar para este celular.',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icons.highlight_off);
    }
  }

  Future<void> _celReplace(String cel) async {
    if (cel != "") {
      var celular = cel
          .replaceAll("(", "")
          .replaceAll(")", "")
          .replaceAll("-", "")
          .replaceAll(" ", "");

      print(celular);

      String message = "Olá";
      FlutterOpenWhatsapp.sendSingleMessage(
        "55$celular",
        Uri.encodeFull(
          message,
        ),
      );
    } else {
      EdgeAlert.show(context,
          title: 'whatsapp Vazio!',
          gravity: EdgeAlert.TOP,
          backgroundColor: Colors.red,
          icon: Icons.highlight_off);
    }
  }

  void _configurandoModalBottomSheet(
      context,
      String idcliente,
      String nomecliente,
      String endereco,
      String tel,
      String cel,
      String whatsapp,
      String whatresp,
      String responsavel,
      String status,
      String idchamada,
      String statuscliente) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: new Icon(
                      Icons.business,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      size: 30,
                    ),
                    title: Text(
                      nomecliente,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: Text(
                      "$endereco \nResponsável: $responsavel",
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        size: 20,
                      ),
                    )),
                Divider(
                  height: 20,
                  color: Colors.blueGrey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => tel == ""
                                    ? edgeAlertWidgetDanger(
                                        context, 'Telefone Vazio!')
                                    : setState(() {
                                        _makePhoneCall(tel);
                                      }),
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.phone,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Telefone',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => cel == ""
                                    ? edgeAlertWidgetDanger(
                                        context, 'Celular Vazio!')
                                    : setState(() {
                                        _makePhoneCall(cel);
                                      }),
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.phone_iphone,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Celular',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => whatsapp == ""
                                    ? edgeAlertWidgetDanger(
                                        context, 'Número do Whatsapp Vazio!')
                                    : _celReplace(whatsapp),
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              FontAwesome.whatsapp,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Whatsapp',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed('/mapacliente');
                                },
                                child: Card(
                                  color: Theme.of(context).buttonColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Icon(
                                              Icons.map,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Mapa',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ButtonTheme(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors.white;
                                },
                              ),
                              shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>(
                                (Set<MaterialState> states) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  );
                                },
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Get.toNamed('/mudarstatus');
                            },
                            child: Text(
                              'Informações',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 10,
                      ),
                      statuscliente == 'ABERTO'
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              child: ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Colors.white;
                                      },
                                    ),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        );
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    agendaController.idcliente.value =
                                        idcliente;
                                    Navigator.of(context).pop();
                                    Get.toNamed('/agendar_visitas');
                                  },
                                  child: Text(
                                    'Agendar Visitas',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Clientes',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return clientesController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : Column(
                    children: [
                      boxSearch(
                          context,
                          visualizarClientesController.search.value,
                          visualizarClientesController.onSearchTextChanged,
                          "Pesquise os Clientes..."),
                      Expanded(
                        child: _listaclientes(),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  _listaclientes() {
    if (clientesController.clientes.length == 0) {
      return Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/semregistro.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 80),
                  //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                ),
                Text(
                  'Sem Registro de Clientes',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return SmartRefresher(
          controller: visualizarClientesController.refreshController,
          onRefresh: visualizarClientesController.onRefresh,
          onLoading: visualizarClientesController.onLoading,
          child: visualizarClientesController.searchResult.isNotEmpty ||
                  visualizarClientesController.search.value.text.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(8),
                  child: ListView(
                    children: [
                      Container(
                          padding: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: visualizarClientesController
                                  .searchResult.length,
                              itemBuilder: (context, index) {
                                var search = visualizarClientesController
                                    .searchResult[index];

                                return GestureDetector(
                                  onTap: () {
                                    clientesController.statuscliente.value =
                                        search.statuscliente;
                                    clientesController.idcliente.value =
                                        search.idcliente;
                                    clientesController.observacao.value =
                                        search.observacao;
                                    clientesController.lat.value = search.lat;
                                    clientesController.lng.value = search.lng;
                                    clientesController.nomecliente.value =
                                        search.nomecliente;
                                    clientesController.endereco.value =
                                        search.endereco;
                                    clientesController.end.value = search.end;
                                    clientesController.numero.value =
                                        search.numero;
                                    clientesController.bairro.value =
                                        search.bairro;
                                    clientesController.cidade.value =
                                        search.cidade;
                                    clientesController.uf.value = search.uf;
                                    clientesController.cep.value = search.cep;
                                    clientesController.tel.value = search.tel;
                                    clientesController.cel.value = search.cel;
                                    clientesController.whatsapp.value =
                                        search.whatsapp;
                                    clientesController.responsavel.value =
                                        search.responsavel;
                                    clientesController.celresp.value =
                                        search.celresp;
                                    clientesController.whatresp.value =
                                        search.whatresp;
                                    clientesController.niveresp.value =
                                        search.niverresp;
                                    clientesController.imgfachada.value =
                                        search.imgfachada;

                                    _configurandoModalBottomSheet(
                                      context,
                                      search.idcliente,
                                      search.nomecliente,
                                      search.endereco,
                                      search.tel,
                                      search.cel,
                                      search.whatsapp,
                                      search.whatresp,
                                      search.responsavel,
                                      search.status,
                                      search.idcliente,
                                      search.statuscliente,
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: search.statuscliente != "ABERTO"
                                        ? Colors.white30
                                        : Colors.green,
                                    child: ListTile(
                                        leading:
                                            search.statuscliente == "ABERTO"
                                                ? Icon(Icons.business_outlined)
                                                : Icon(Icons.block),
                                        title: Container(
                                          child: Center(
                                            child: Text(
                                              search.nomecliente,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: search.status ==
                                                          'Pendente'
                                                      ? Colors.black
                                                      : Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_right,
                                          color: search.status == 'Pendente'
                                              ? Colors.black
                                              : Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                          size: 30,
                                        )),
                                  ),
                                );
                              }))
                    ],
                  ))
              : _containerList());
    }
  }

  _containerList() {
    return Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: clientesController.clientes.length,
                    itemBuilder: (context, index) {
                      var clientes = clientesController.clientes[index];
                      return GestureDetector(
                        onTap: () {
                          clientesController.statuscliente.value =
                              clientes.statuscliente;
                          clientesController.idcliente.value =
                              clientes.idcliente;
                          clientesController.observacao.value =
                              clientes.observacao;
                          clientesController.lat.value = clientes.lat;
                          clientesController.lng.value = clientes.lng;
                          clientesController.nomecliente.value =
                              clientes.nomecliente;
                          clientesController.endereco.value = clientes.endereco;
                          clientesController.end.value = clientes.end;
                          clientesController.numero.value = clientes.numero;
                          clientesController.bairro.value = clientes.bairro;
                          clientesController.cidade.value = clientes.cidade;
                          clientesController.uf.value = clientes.uf;
                          clientesController.cep.value = clientes.cep;
                          clientesController.tel.value = clientes.tel;
                          clientesController.cel.value = clientes.cel;
                          clientesController.whatsapp.value = clientes.whatsapp;
                          clientesController.responsavel.value =
                              clientes.responsavel;
                          clientesController.celresp.value = clientes.celresp;
                          clientesController.whatresp.value = clientes.whatresp;
                          clientesController.niveresp.value =
                              clientes.niverresp;
                          clientesController.imgfachada.value =
                              clientes.imgfachada;
                          _configurandoModalBottomSheet(
                            context,
                            clientes.idcliente,
                            clientes.nomecliente,
                            clientes.endereco,
                            clientes.tel,
                            clientes.cel,
                            clientes.whatsapp,
                            clientes.whatresp,
                            clientes.responsavel,
                            clientes.status,
                            clientes.idcliente,
                            clientes.statuscliente,
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: clientes.statuscliente != "ABERTO"
                              ? Colors.white30
                              : Colors.green,
                          child: ListTile(
                              leading: clientes.statuscliente == "ABERTO"
                                  ? Icon(Icons.business_outlined)
                                  : Icon(Icons.block),
                              title: Container(
                                child: Center(
                                  child: Text(
                                    clientes.nomecliente,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: clientes.status == 'Pendente'
                                            ? Colors.black
                                            : Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_right,
                                color: clientes.status == 'Pendente'
                                    ? Colors.black
                                    : Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                size: 30,
                              )),
                        ),
                      );
                    }))
          ],
        ));
  }
}
