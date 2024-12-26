import 'package:get/get.dart';
import 'package:note_taker/models/note.dart';
import 'package:note_taker/services/pb_service.dart';

class ViewNoteController extends GetxController {
  var pb = Get.find<PBService>();
  var isEditing = false.obs;
  edit(Note original, Note updated) async {
    if (original.content == updated.content) return;
    if (updated.content.isEmpty) return;

    await pb.edit(updated);
  }
}
