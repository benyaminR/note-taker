import 'package:get/get.dart';
import 'package:note_taker/services/pb_service.dart';
import 'package:pocketbase/pocketbase.dart';

class AuthController extends GetxController {
  final PBService pb = Get.find();

  var userAuth = RecordModel().obs;

  Future<void> signInWithUsernameAndPassword(
      String email, String password) async {
    try {
      userAuth.value = await pb.authenticateWithPassword(email, password);
      Get.snackbar("Welcome", "Successfully signed in");
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back();
    }
  }

  void signOut() async {
    try {} catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onInit() {
    var userData = pb.getCurrentUser();
    if (userData != null) {
      userData = pb.getCurrentUser();
    }
  }
}
