import 'package:apbelem/modules/Home/home_controller.dart';
import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:apbelem/utils/auth_controller.dart';
import 'package:apbelem/utils/edge_alert_danger.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dart:core';

class LoginPage extends StatelessWidget {
  final LoginController loginController =
      Get.put(LoginController(), permanent: true);

  final HomePageController homePageController = Get.put(HomePageController());

  final AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(children: <Widget>[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 120),
                          child: Image.asset(
                            "images/logo.png",
                            fit: BoxFit.fill,
                            width: 120,
                          ),
                        ),
                      ),
                    ])),
                Positioned(
                  top: 220,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/banner.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                  ),
                ),
                /*Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/banner.jpg'),
                          fit: BoxFit.cover)),*/
                Column(
                  children: <Widget>[
                    Center(
                      child: Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 320, 20, 20),
                              child: Container(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    labelText: 'Entre com o e-mail',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14),
                                    errorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red)),
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).errorColor),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (valueEmail) {
                                    if (!EmailValidator.validate(valueEmail)) {
                                      return 'Entre com E-mail Válido!';
                                    }
                                    return null;
                                  },
                                  controller: loginController.email.value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
                              child: Container(
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).accentColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    labelText: 'Entre com a senha',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14),
                                    errorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red)),
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context).errorColor),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (valueSenha) {
                                    if (valueSenha == "") {
                                      return 'Campo Senha Vazio!';
                                    }
                                    return null;
                                  },
                                  controller: loginController.password.value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).primaryColor;
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
                                    if (loginController.email.value.text ==
                                            '' ||
                                        loginController.password.value.text ==
                                            '') {
                                      edgeAlertWidgetDangerTop(
                                        context,
                                        'Campo E-mail ou Senha Vazio!',
                                      );
                                    }
                                    if (_formKey.currentState.validate()) {
                                     
                                      loginController.login().then(
                                        (value) {
                                          if (value == null) {
                                            loginController
                                                .password.value.text = '';
                                            edgeAlertWidgetDangerTop(
                                              context,
                                              'Email ou Senha Inválidos!',
                                            );
                                          } else {
                                            loginController.idusu.value =
                                                value['idusu'];
                                            loginController.nome.value =
                                                value['nome'];
                                            loginController.imgperfil.value =
                                                value['imgperfil'];
                                            loginController.tipousu.value =
                                                value['tipousu'];
                                            loginController.birthdate.value =
                                                value['birthdate'];
                                            loginController.genero.value =
                                                value['genero'];
                                            loginController.phone.value =
                                                value['phone'];

                                                 loginController.storageId();

                                            Get.toNamed('/home');
                                          }
                                        },
                                      );
                                    }
                                  },
                                  child: loginController.isLoading.value
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "Entrar",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 30, 0, 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        FlutterOpenWhatsapp.sendSingleMessage(
                                            "5591981220670", "Olá");
                                      },
                                      child: Text(
                                        "Fale com o Suporte",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/esqueci');
                                      },
                                      child: Text(
                                        "Esqueceu a Senha?",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            )
                            /*Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: ButtonTheme(
                                height: 50,
                                child: TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .accentColor
                                          .withOpacity(.5),
                                    ),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                  ),
                                  onPressed: () {
                                    Get.toNamed('/esqueci');
                                  },
                                  child: Text(
                                    "Esqueceu a Senha?",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.red, fontSize: 12),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                            ),*/

                            /*GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/esqueci');
                                        },
                                        child: Row(children: [
                                          Column(
                                            children: [
                                              Icon(Icons.lock_outline,
                                                  size: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  "Esqueci a Senha",
                                                  style: GoogleFonts.montserrat(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 12),
                                                  textDirection:
                                                      TextDirection.ltr,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
