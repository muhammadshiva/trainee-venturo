import 'package:coffee_app/modules/features/login/repositories/login_repository.dart';
import 'package:coffee_app/modules/models/user.dart';
import 'package:coffee_app/shared/customs/error_snack_bar.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find<LoginController>();

  /// Login using email and password
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    // Call API repository
    UserResponse userResponse = await LoginRepository.getUser(email, password);

    if (userResponse.statusCode == 200) {
      // Set token and user
      await LocalDBServices.setUser(userResponse.user!);
      await LocalDBServices.setToken(userResponse.token!);

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
}
