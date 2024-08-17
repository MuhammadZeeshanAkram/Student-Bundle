import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/aiimage.dart';
import 'package:mad_project/bot.dart';
import 'package:mad_project/quiz/splashscreen.dart';
import 'package:mad_project/summarizer.dart';
import 'package:mad_project/textdect.dart';
import 'package:mad_project/todo.dart';



// ignore: must_be_immutable
class HomePage extends StatelessWidget {
   HomePage({super.key});
   
   var height, width;
   List imgData = [
    "assets/images/chatbot.png",
    "assets/images/imgtotext.png",
    "assets/images/text summarization.png",
    "assets/images/todo2.png",
    "assets/images/quiz.png",
    "assets/images/imageexplain.png",
   ];

   List Tiles = [   
    "Chat Bot",
    "Text detector",
    "\t\t\t\t\t\t\tText\n Summarizer",
    "To-Do List",
    "Quiz",
    "Image Explainer",
   ];

   signout() async {
    await FirebaseAuth.instance.signOut(); 
  }
  final user=FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 31, 44, 54),
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.25,
              width: width,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding: EdgeInsets.only(
                      top: 100,
                      left: 73,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 230, 235, 240),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                  ),
                  width: width,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imgData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                           switch (index) {
                            case 0:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AiBotScreen(title:'ai bot')));
                              break;
                            case 1:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TextDetection()));
                              break;
                            case 2:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TextSummarizer()));
                              break;
                            case 3:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TodoScreen()));
                              break;
                            case 4:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizSplashScreen()));
                              break;
                            case 5:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AiImageScreen()));
                              break;
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 31, 44, 54),
                                spreadRadius: 1,
                                blurRadius: 6,
                              )
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(imgData[index],
                                width: 100,
                              ),
                              Text(Tiles[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 40), // Add padding here
        child: FloatingActionButton(
          onPressed: () => signout(),
          backgroundColor: const Color.fromARGB(255, 31, 44, 54), // Set the background color
          foregroundColor: Colors.white,
          child: const Icon(Icons.login_rounded),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
