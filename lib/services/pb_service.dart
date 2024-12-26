import 'package:note_taker/models/note.dart';
import 'package:pocketbase/pocketbase.dart';

class PBService {
  final pb = PocketBase('http://10.0.2.2:8090');

  Future<RecordModel> authenticateWithPassword(
      String email, String password) async {
    try {
      var authData =
          await pb.collection("users").authWithPassword(email, password);
      return authData.record;
    } on ClientException catch (e) {
      print("Failed to authenticated - Creating a new user");

      final body = <String, dynamic>{
        "password": password,
        "passwordConfirm": password,
        "email": email,
      };
      var newUser = await pb.collection("users").create(body: body);
      var authData =
          await pb.collection("users").authWithPassword(email, password);
      return authData.record;
    }
  }

  clearAuthToken() async {
    pb.authStore.clear();
  }

  Future<bool> create(Note note) async {
    try {
      await pb.collection("notes").create(body: note.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit(Note note) async {
    try {
      await pb.collection("notes").update(note.recordId, body: note.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(String recordId) async {
    try {
      await pb.collection("notes").delete(recordId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Note>> getAll() async {
    try {
      var records = await pb
          .collection("notes")
          .getFullList(filter: 'author="${pb.authStore.record?.id}"');
      return records
          .map((e) => Note(
              recordId: e.id,
              content: e.data['content'],
              author: e.data['author']))
          .toList();
    } catch (e) {
      return [];
    }
  }

  RecordModel? getCurrentUser() {
    return pb.authStore.record;
  }
}
