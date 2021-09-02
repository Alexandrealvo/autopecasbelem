import 'dart:io';

import 'package:apbelem/modules/Chamadas/status_controller.dart';
import 'package:apbelem/modules/Clientes/clientes_controller.dart';
import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:apbelem/utils/circular_progress_indicator.dart';
import 'package:apbelem/utils/custom_text_field.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

class DadosCliente extends StatefulWidget {
  @override
  _DadosClienteState createState() => _DadosClienteState();
}

class _DadosClienteState extends State<DadosCliente> {
  StatusController statusController = Get.put(StatusController());
  ClientesController clientesController = Get.put(ClientesController());
  LoginController loginController = Get.put(LoginController());

  File _selectedFile;
  final _picker = ImagePicker();
  void dropDownFavoriteSelected(String novoItem) {
    statusController.firstId.value = novoItem;
  }

  final uri = Uri.parse(
      "https://admautopecasbelem.com.br/login/flutter/upload_imagem_fachada.php");

  getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile image = await _picker.getImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 2, ratioY: 1),
          compressQuality: 90,
          maxWidth: 400,
          maxHeight: 300,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Imagem para a fachada",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = File(image.path);
        _selectedFile = cropped;
        if (cropped != null) {
          uploadImage();
          clientesController.getclientes();
          Get.back();
        }
      });
    }
  }

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idcliente'] = clientesController.idcliente.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      EdgeAlert.show(context,
          title: 'Imagem da fachada alterada',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.green,
          icon: Icons.check);
    } else {
      Navigator.of(context).pop();
      EdgeAlert.show(context,
          title: 'Imagem não enviada',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icons.highlight_off);
    }
    _selectedFile = null;
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.only(bottom: 30),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Center(
                        child: Text(
                  "Inserir Imagem",
                  style: GoogleFonts.montserrat(fontSize: 14),
                ))),
                Divider(
                  height: 18,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    title: new Text('Câmera'),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    onTap: () => {getImage(ImageSource.camera)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(Icons.collections,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    title: new Text('Galeria de Fotos'),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    onTap: () => {getImage(ImageSource.gallery)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
          //Navigator.pushNamed(context, '/Home');
        },
        child: Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: new DecorationImage(
              image: new FileImage(_selectedFile),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
          //Navigator.pushNamed(context, '/Home');
        },
        child: clientesController.imgfachada.value == ''
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Center(
                            child: Icon(
                              Icons.image_search_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          Center(
                            child: Text('Insira Imagem da Fachada'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).accentColor,
                ),
                width: 200,
                height: 150,
              )
            : Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 3, color: Theme.of(context).buttonColor),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://admautopecasbelem.com.br/login/areadm/downloads/fotosclientesfachadas/${clientesController.imgfachada.value}',
                    ),
                  ),
                ),
              ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return clientesController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    padding: EdgeInsets.all(8),
                    //height: MediaQuery.of(context).size.height * .95,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        getImageWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).buttonColor,
                              width: 3,
                            ),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 27,
                            ),
                            iconEnabledColor: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            dropdownColor: Theme.of(context).primaryColor,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            items: statusController.tipos
                                .map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String novoItemSelecionado) {
                              dropDownFavoriteSelected(novoItemSelecionado);
                              statusController.itemSelecionado.value =
                                  novoItemSelecionado;
                            },
                            value: statusController.itemSelecionado.value,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: customTextField(
                            context,
                            "Observação...",
                            clientesController.observacao.value,
                            true,
                            4,
                            true,
                            statusController.observacao.value,
                            false,
                          ),
                        ),
                        customTextField(
                          context,
                          'Fantasia',
                          null,
                          false,
                          1,
                          true,
                          statusController.fantasia.value,
                          false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        customTextField(
                          context,
                          'Endereço',
                          null,
                          false,
                          1,
                          true,
                          statusController.end.value,
                          false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        customTextField(
                          context,
                          'Número',
                          null,
                          false,
                          1,
                          true,
                          statusController.numero.value,
                          false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        customTextField(
                          context,
                          'Bairro',
                          null,
                          false,
                          1,
                          true,
                          statusController.bairro.value,
                          false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        customTextField(
                          context,
                          'Cidade',
                          null,
                          false,
                          1,
                          true,
                          statusController.cidade.value,
                          false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        customTextField(
                          context,
                          'UF',
                          null,
                          false,
                          1,
                          true,
                          statusController.uf.value,
                          false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [statusController.cepMaskFormatter],
                          controller: statusController.cep.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Cep',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [statusController.telMaskFormatter],
                          controller: statusController.telefone.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Telefone',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [statusController.cellMaskFormatter],
                          controller: statusController.celular.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Celular',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [statusController.cellMaskFormatter],
                          controller: statusController.whats.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                            labelText: 'Whatsapp',
                            labelStyle: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Theme.of(context).accentColor;
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
                              statusController.handleAddPage();
                            },
                            child: Text(
                              "Continuar",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
