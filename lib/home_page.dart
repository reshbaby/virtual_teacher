import 'package:ai_teacher/utils/pick_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  FlutterTts flutterTts = FlutterTts();

  void stop() async {
    await flutterTts.stop();
  }

  // Updated method to speak text line by line
  void speakLineByLine(String text) async {
    List<String> lines = text.split('\n'); // Split text into lines

    for (String line in lines) {
      if (line.isNotEmpty) {
        await flutterTts.speak(line);
        await flutterTts
            .awaitSpeakCompletion(true); // Wait for TTS to finish each line
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Aloud"),
        actions: [
          IconButton(
              onPressed: () {
                stop();
              },
              icon: const Icon(Icons.stop)),
          IconButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  speakLineByLine(controller.text.trim()); // Speak line by line
                }
              },
              icon: const Icon(Icons.mic))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          controller: controller,
          maxLines: MediaQuery.of(context).size.height.toInt(),
          decoration: const InputDecoration(
              border: InputBorder.none, label: Text("Text to read...")),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String text = await pickDocument();
          if (text.isNotEmpty) {
            setState(() {
              controller.text = text;
            });
          }
        },
        label: const Text("Pick from Pdf"),
      ),
    );
  }
}
