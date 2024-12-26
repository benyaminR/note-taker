import 'package:pocketbase/pocketbase.dart';

class PBService {
  final pb = PocketBase('http://10.0.2.2:8090');

  Future<RecordAuth> authenticateWithPassword(
      String email, String password) async {
    try {
      var authData =
          await pb.collection("users").authWithPassword(email, password);
      return authData;
    } on ClientException catch (e) {
      print("Failed to authenticated - Creating a new user");

      final body = <String, dynamic>{
        "password": password,
        "passwordConfirm": password,
        "email": email,
      };
      var newUser = await pb.collection("users").create(body: body);
      var authData = pb.collection("users").authWithPassword(email, password);
      return authData;
    }
  }

  clearAuthToken() async {
    pb.authStore.clear();
  }
}
