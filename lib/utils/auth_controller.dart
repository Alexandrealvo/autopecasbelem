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
    var email = box.read('emailController');
    var senha = box.read('password');

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
        loginController.isLoading.value = true;

        loginController.loginAuth(senha, email).then((value) {
         
          loginController.idusu.value = value['idusu'];
          loginController.nome.value = value['nome'];
          loginController.imgperfil.value = value['imgperfil'];
          loginController.tipousu.value = value['tipousu'];
          loginController.birthdate.value = value['birthdate'];
          loginController.genero.value = value['genero'];
          loginController.phone.value = value['phone'];
          Get.toNamed('/home');
          loginController.isLoading.value = false;
        });
       

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
