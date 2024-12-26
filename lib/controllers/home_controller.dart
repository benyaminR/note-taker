import 'package:get/get.dart';
import 'package:note_taker/models/note.dart';
import 'package:note_taker/services/pb_service.dart';

class HomeController extends GetxController {
  final pb = Get.find<PBService>();
  var notes = RxList<Note>();

  @override
  void onInit() {
    fetchNotes();
  }

  fetchNotes() async {
    notes.value = await pb.getAll();
  }

  delete(String recordId) async {
    await pb.delete(recordId);
  }
}
