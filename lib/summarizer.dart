import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TextSummarizer extends StatefulWidget {
  const TextSummarizer({super.key});

  @override
  State<TextSummarizer> createState() => _TextSummarizerState();
}

class _TextSummarizerState extends State<TextSummarizer> {
  final TextEditingController inputText = TextEditingController();
  final TextEditingController suggestion = TextEditingController();

  String summary = '';
  bool scanning = false;

  final apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyBtPG6L0gk0rgKdxu7L63RyVHzy5I3nWEc';
  final headers = {
    'Content-Type': 'application/json',};

  getdata(myText,howToSummarize) async {
    setState(() {
      scanning = true;
    });
    var data = {
      
        "contents": [
          {
            "parts": [
              {'text': "$howToSummarize - $myText"}
            ]
          } 
        ]
      
    };
    await http.post(
      Uri.parse(apiUrl),
       headers: headers, 
       body: jsonEncode(data)).then((response) {
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);
        setState(() {
          summary = result['candidates'][0]['content']['parts'][0]['text'];
          
        });
      } else {
        print('Requeset failed with status: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error:$error');
    });
    setState(() {
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text Summarization'),
          backgroundColor: Colors.black,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                controller: inputText,
                maxLines: 10,
                decoration: const InputDecoration(
                    
                     hintText: 'Enter Text to Summarize'
                     ),
              ),
              const SizedBox(height: 16.0,),
              TextField(
                controller: suggestion,
                maxLines: 1, 
                decoration: const InputDecoration(
                     hintText: 'How to Summarize'),
              ),
              const SizedBox(height: 16.0,),
              ElevatedButton(
                onPressed: () async{
                  getdata(inputText.text, suggestion.text);
                }, child: const Text('Summarize Text', style: TextStyle(color: Color.fromARGB(255, 17, 17, 17)), ),
                ),
                
                 const SizedBox(height: 16.0,),
                 scanning?
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    
                  ):Padding(
                    padding: const EdgeInsets.all(18.0),
                    child:Text(summary,style:const TextStyle(fontSize: 17),),
                  
                    
                    ),
                    const SizedBox(height: 60.0,),
                 
            ],
          ),
        )
        );
  }
}
