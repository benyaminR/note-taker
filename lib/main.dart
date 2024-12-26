import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/add_note_view.dart';
import 'package:note_taker/auth_binding.dart';
import 'package:note_taker/controllers/auth_controller.dart';
import 'package:note_taker/home_view.dart';
import 'package:note_taker/login_view.dart';
import 'package:note_taker/services/pb_service.dart';

void main() async {
  await initDependencies();
  runApp(GetMaterialApp(
    initialBinding: AuthBinding(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: AppRoutes.routes,
    theme: ThemeData(
        useMaterial3: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.yellow, brightness: Brightness.dark)),
  ));
}

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PBService());
}

class Root extends GetWidget<AuthController> {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        controller.userAuth.value.id.isNotEmpty ? HomeView() : LoginView());
  }
}

class AppRoutes {
  static final routes = [
    GetPage(
      name: Root.routeName,
      page: () => Root(),
    ),
    GetPage(name: AddNoteView.routeName, page: () => AddNoteView()),
  ];
}
