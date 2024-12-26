import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:note_taker/controllers/view_note_controller.dart';
import 'package:note_taker/models/note.dart';

class ViewNoteView extends StatelessWidget {
  final ViewNoteController viewNoteController = Get.put(ViewNoteController());
  static const String routeName = '/viewNote';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Note note = Get.arguments;
    _controller.text = note.content;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
        final NavigatorState navigator = Navigator.of(context);
        print("Updating" + _controller.text);

        var original = note;
        var updated = Note(
            recordId: original.recordId,
            content: _controller.text,
            author: original.author);
        await viewNoteController.edit(original, updated);
        final bool? shouldPop = true;
        if (shouldPop ?? false) {
          navigator.pop();
        }
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => viewNoteController.isEditing.value
                ? Column(
                    children: [
                      // Fullscreen input field
                      Expanded(
                        child: TextField(
                          onSubmitted: (s) =>
                              viewNoteController.isEditing(false),
                          controller: _controller,
                          maxLines: 99999, // Allow the input to expand
                          decoration: InputDecoration(
                            hintText: 'Enter text...',
                            //border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          autofocus: true,
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    child: HtmlWidget(_controller.text),
                    onTap: () {
                      viewNoteController.isEditing(true);
                    },
                  )),
          )),
    );
  }
}
