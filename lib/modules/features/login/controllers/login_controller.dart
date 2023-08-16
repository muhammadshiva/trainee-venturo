import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/modules/features/login/repositories/login_repository.dart';
import 'package:coffee_app/modules/global_controller/global_controller.dart';
import 'package:coffee_app/modules/models/user.dart';
import 'package:coffee_app/shared/customs/error_snack_bar.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  @override
  Future<void> onInit() async {
    super.onInit();

    // Delay 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Check internet connection
    GlobalController.to.checkConnectivity();
  }

  /// Login using email and password
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    // Call API repository
    UserResponse userResponse = await LoginRepository.getUser(email, password);

    if (userResponse.statusCode == 200) {
      // Set token and user
      await LocalDBServices.setUser(userResponse.user!);
      await LocalDBServices.setToken(userResponse.token!);

      print('Succes Login');

      // If success, go to dashboard page
      Get.offAllNamed('/dashboard');
    } else if (userResponse.statusCode == 422 || userResponse.statusCode == 204) {
      // Show snackbar if usename or password is wrong
      Get.showSnackbar(
        ErrorSnackBar(
          title: 'Something went wrong'.tr,
          message: 'Email or password is incorrect'.tr,
        ),
      );
    } else {
      // Show snackbar for unknown error
      Get.showSnackbar(
        ErrorSnackBar(
          title: 'Something went wrong'.tr,
          message: userResponse.message ?? 'Unkown error'.tr,
        ),
      );
    }
  }

  // Login by google account
  Future<void> loginWithGoogle() async {
    /// Singleton GoogleSignIn
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Sign out dari akun saat ini (apabila ada) dan sign in
    await googleSignIn.signOut();

    // Request login dengan akun google
    GoogleSignInAccount? account = await googleSignIn.signIn();

    // If account is null
    if (account == null) return;

    // Call API repository
    UserResponse userResponse = await LoginRepository.getUserFromGoogle(
      account.displayName ?? '-',
      account.email,
    );

    if (userResponse.statusCode == 200) {
      // Set token and user
      await LocalDBServices.setUser(userResponse.user!);
      await LocalDBServices.setToken(userResponse.token!);

      // Going to dashboard page;
      Get.offAllNamed('/dashboard');
    } else {
      // Show error unknow snackbar
      Get.showSnackbar(
        ErrorSnackBar(
          title: 'Something went wrong'.tr,
          message: 'Unknown error'.tr,
        ),
      );
    }
  }

  /// Logout user
  Future<void> logout() async {
    await LocalDBServices.clearToken();
    await LocalDBServices.clearUser();
    print('Logout success');
    Get.offAllNamed(AppRoutes.loginView);
  }
}
