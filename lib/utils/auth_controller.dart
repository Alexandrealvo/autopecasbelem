import 'package:apbelem/modules/Login/login_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class AuthController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  LocalAuthentication localAuthentication = LocalAuthentication();

  bool canCheckBiometrics;
  List<BiometricType> availableBiometrics;
  bool isAuthenticating = false;

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await autoLogIn();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> autoLogIn() async {
    await GetStorage.init();
    final box = GetStorage();
    var email = box.read('email');

    if (email != null) {
      bool isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        biometricOnly: true,
        stickyAuth: true,
        useErrorDialogs: true,
        iOSAuthStrings: IOSAuthMessages(
          cancelButton: "Cancelar",
        ),
        androidAuthStrings: AndroidAuthMessages(
          biometricHint: "Para acesso rapido entre com sua biometria",
          signInTitle: "Entre com a biometria",
          cancelButton: "Cancelar",
        ),
      );

      if (isAuthenticated) {
        /* loginController.isLoading.value = true;
        http.post(Uri.https('www.condosocio.com.br', '/flutter/dados_usu.php'),
            body: {"id": id}).then((response) {
          loginController.hasMoreEmail(email).then((value) {
            if (value.length > 1) {
              Get.toNamed('/listOfCondo');
              loginController.isLoading.value = false;
              loginController.haveListOfCondo.value = true;
            } else {
              var dados = json.decode(response.body);
              print('auth: $dados');
              loginController.haveListOfCondo.value = false;
              loginController.id(dados['idusu']);
              loginController.idcond(dados['idcond']);
              loginController.emailUsu(dados['email']);
              loginController.tipo(dados['tipo']);
              loginController.imgperfil(dados['imgperfil']);
              loginController.nomeCondo(dados['nome_condo']);
              loginController.imgcondo(dados['imgcondo']);
              loginController.nome(dados['nome']);
               loginController.sobrenome(dados['sobrenome']);
              loginController.condoTheme(dados['cor']);
              loginController.genero(dados['genero']);
              loginController.birthdate(dados['aniversario']);
              loginController.phone(dados['cel']);
              loginController.logradouro(dados['logradouro']);
              loginController.tipoun(dados['tipoun']);
              loginController.idadm(dados['idadm']);
               loginController.dep(dados['dep']);
              loginController
                  .websiteAdministradora(dados['website_administradora']);
              loginController.licenca(dados['licenca']);

              themeController.setTheme(loginController.condoTheme.value);

            
            }
          });
        });*/

        Get.toNamed('/home');
        loginController.isLoading.value = false;
      } else {
        loginController.isLoading.value = false;
        return;
      }
    }
  }

  @override
  void onInit() {
    localAuthentication.isDeviceSupported().then((isSupported) {
      if (isSupported) {
        authenticate();
      }
    });
    super.onInit();
  }
}