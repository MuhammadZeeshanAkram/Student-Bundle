import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AiImageScreen extends StatefulWidget {
  const AiImageScreen({super.key});

  @override
  State<AiImageScreen> createState() => _AiImageScreenState();
}

class _AiImageScreenState extends State<AiImageScreen> {
  XFile? pickedImage;
  String myText = '';
  bool scanning = false;

  TextEditingController prompt = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  final String oururl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyACfVxWgOM6djGRNVW0Jr-uyj1PfO_j75o';

  final header = {'Content-Type': 'application/json'};

  Future<void> getImage(ImageSource ourSource) async {
    try {
      XFile? result = await _imagePicker.pickImage(source: ourSource);

      if (result != null) {
        setState(() {
          pickedImage = result;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> getdata(XFile? image, String promptValue) async {
    if (image == null) return;
    setState(() {
      scanning = true;
      myText = '';
    });
    try {
      List<int> imageBytes = File(image.path).readAsBytesSync();
      String base64File = base64.encode(imageBytes);

      final data = {
        "contents": [
          {
            "parts": [
              {"text": promptValue},
              {
                "inlineData": {
                  "mimetype": "image/jpeg",
                  "data": base64File,
                }
              }
            ]
          }
        ],
      };

      final response = await http.post(Uri.parse(oururl), headers: header, body: jsonEncode(data));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        setState(() {
          myText = result['candidates'][0]['content']['parts'][0]['text'] ?? 'No text found';
        });
      } else {
        setState(() {
          myText = 'Response Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error occurred: $e');
    }

    setState(() {
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Explainer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            icon: const Icon(Icons.photo, color: Colors.white),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            pickedImage == null
                ? Container(
                    height: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                    child: const Center(
                      child: Text('No Image Selected', style: TextStyle(fontSize: 22)),
                    ),
                  )
                : SizedBox(
                    height: 340,
                    child: Center(
                      child: Image.file(
                        File(pickedImage!.path),
                        height: 400,
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            TextField(
              controller: prompt,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: const Icon(
                  Icons.pending_sharp,
                  color: Colors.black,
                ),
                hintText: 'Enter your prompt here',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                getdata(pickedImage, prompt.text);
              },
              icon: const Icon(Icons.generating_tokens_rounded, color: Colors.white),
              label: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Generate Answer', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            ),
            const SizedBox(height: 30),
            scanning
                ? const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(
                      child: SpinKitThreeBounce(color: Colors.black, size: 20),
                    ),
                  )
                : Text(myText, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
