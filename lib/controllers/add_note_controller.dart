import 'package:get/get.dart';
import 'package:note_taker/models/note.dart';
import 'package:note_taker/services/pb_service.dart';

class AddNoteController extends GetxController {
  var pb = Get.find<PBService>();

  addNote(String content) async {
    if (content.isEmpty) return;

    var relationId = pb.getCurrentUser()!.id;

    await pb.create(Note(recordId: "", content: content, author: relationId));
  }
}
