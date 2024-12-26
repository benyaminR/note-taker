import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:note_taker/views/add_note_view.dart';
import 'package:note_taker/controllers/home_controller.dart';
import 'package:note_taker/views/view_note_view.dart';

class HomeView extends StatelessWidget {
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(AddNoteView.routeName);
          homeController.fetchNotes();
        },
        child: Icon(Icons.add),
      ),
      body: Obx(() => homeController.notes.isEmpty
          ? Center(
              child: Text("No notes found"),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Get.toNamed(ViewNoteView.routeName,
                        arguments: homeController.notes[index]);
                    await homeController.fetchNotes();
                  },
                  onLongPress: () {
                    Get.defaultDialog(
                        title: "Warning",
                        middleText: "Do you want to this note?",
                        textConfirm: "Delete",
                        onConfirm: () async {
                          Get.back();
                          await homeController
                              .delete(homeController.notes[index].recordId);
                          await homeController.fetchNotes();
                        },
                        textCancel: "Cancel",
                        onCancel: () => Get.back());
                  },
                  child: SizedBox(
                    height: 250,
                    child: Card(
                      margin: EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0),
                              ],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds);
                          },
                          child: ClipRect(
                            clipBehavior: Clip.antiAlias,
                            child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: HtmlWidget(
                                    homeController.notes[index].content)),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: homeController.notes.value.length,
            )),
    );
  }
}
