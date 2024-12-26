import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_taker/controllers/add_note_controller.dart';

class AddNoteView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final AddNoteController addNoteController = Get.put(AddNoteController());
  AddNoteView({Key? key}) : super(key: key);
  static const String routeName = '/addNote';
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
        final NavigatorState navigator = Navigator.of(context);
        print("Saving" + _controller.text);
        await addNoteController.addNote(_controller.text);
        final bool? shouldPop = true;
        if (shouldPop ?? false) {
          navigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            // Fullscreen input field
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  maxLines: 99999, // Allow the input to expand
                  decoration: InputDecoration(
                    hintText: 'Enter text...',
                    //border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
