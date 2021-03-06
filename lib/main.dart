import 'package:apbelem/modules/Agenda/agendar_visitas.dart';
import 'package:apbelem/modules/Agenda/detalhes_visita.dart';
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
import 'package:apbelem/modules/MapaAgenda/mapa_agenda_page.dart';
import 'package:apbelem/modules/MapaListaClientes/mapa_list_clientes.dart';
import 'package:apbelem/modules/Perfil/perfil.dart';
import 'package:apbelem/modules/Senha/senha.dart';
import 'package:apbelem/modules/Visitas/visitas_page.dart';
import 'package:apbelem/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'modules/Login/login_page.dart';
import 'modules/MapaAgenda/components/InfoCheck/info_check_page.dart';
import 'modules/Visitas/components/DataTable/data_table_visitas_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("258497a7-3022-43c7-98df-4643394dccb3");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      var titulo = result.notification.title;
      print('NOTIFICACAO ABERTA: $titulo');
      if (titulo == 'CHAMADAS') {
        Get.toNamed('/chamadas');
      } else if (titulo == 'COMUNICADOS') {
        Get.toNamed('/comunicados');
      } else {}
    });

    return GetMaterialApp(
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
        GetPage(
          name: '/mapaAgenda',
          page: () => MapaAgendaPage(),
        ),
        GetPage(
          name: '/infoCheck',
          page: () => InfoCheckPage(),
        ),
        GetPage(
          name: '/visitas',
          page: () => VisitasPage(),
        ),
        GetPage(
          name: '/dataTableVisitas',
          page: () => DataTableVisitas(),
        ),
        GetPage(
          name: '/detalhesvisitas',
          page: () => DetalhesVisita(),
        ),
        GetPage(
          name: '/mapalistaclientes',
          page: () => MapaListaClientes(),
        ),
      ],
    );
  }
}
