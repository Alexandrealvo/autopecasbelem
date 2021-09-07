import 'package:apbelem/modules/Agenda/agendar_visitas.dart';
import 'package:apbelem/modules/Agenda/visualizar_agenda.dart';
import 'package:apbelem/modules/AgendarHorario/agendarhorario.dart';
import 'package:apbelem/modules/Chamadas/chamadas.dart';
import 'package:apbelem/modules/Chamadas/status_cliente.dart';
import 'package:apbelem/modules/Clientes/clientes.dart';
import 'package:apbelem/modules/Clientes/dadosresponsavel.dart';
import 'package:apbelem/modules/Comunicados/components/detalhes_comunicados_page.dart';
import 'package:apbelem/modules/Comunicados/comunicados.dart';
import 'package:apbelem/modules/Esqueci/esqueci_senha.dart';
import 'package:apbelem/modules/Home/home_page.dart';
import 'package:apbelem/modules/Mapa/mapa_cliente.dart';
import 'package:apbelem/modules/Perfil/perfil.dart';
import 'package:apbelem/modules/Senha/senha.dart';
import 'package:apbelem/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'modules/Login/login_page.dart';

void main() {
  runApp(GetMaterialApp(
    localizationsDelegates: [
      RefreshLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [Locale('pt')],
    initialRoute: '/login',
    theme: admin,
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(
        name: '/login',
        page: () => LoginPage(),
      ),
      GetPage(
        name: '/home',
        page: () => HomePage(),
      ),
      GetPage(
        name: '/senha',
        page: () => Senha(),
      ),
      GetPage(
        name: '/perfil',
        page: () => Perfil(),
      ),
      GetPage(
        name: '/chamadas',
        page: () => Chamadas(),
      ),
      GetPage(
        name: '/mudarstatus',
        page: () => MudarStatus(),
      ),
      GetPage(
        name: '/mapacliente',
        page: () => MapaCliente(),
      ),
      GetPage(
        name: '/esqueci',
        page: () => Esqueci(),
      ),
      GetPage(
        name: '/clientes',
        page: () => Clientes(),
      ),
      GetPage(
        name: '/dadosresp',
        page: () => DadosResp(),
      ),
      GetPage(
        name: '/agendar_visitas',
        page: () => AgendarVisitas(),
      ),
      GetPage(
        name: '/visualizar_agenda',
        page: () => VisualizarAgenda(),
      ),
      GetPage(
        name: '/comunicados',
        page: () => Comunicados(),
      ),
      GetPage(
        name: '/detalhesComunicados',
        page: () => DetalhesComunicadosPage(),
      ),
       GetPage(
        name: '/agendarhorario',
        page: () => AgendarHorario(),
      ),
    ],
  ));
}
