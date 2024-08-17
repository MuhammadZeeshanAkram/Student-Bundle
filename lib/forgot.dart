import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController email = TextEditingController();

  
  forgot()async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text); 
    
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/register.png"), fit: BoxFit.fill),
      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
             Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:  const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/finallogo.png",
                      width: 80, // Set your desired width
                      height: 80, // Set your desired height
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Forgot your\n Password!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.5,
                  right:35,
                  left: 35, 
                ),
                child:  Column(
                  children: [
                    TextField(
                      controller:email,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Enter your Email for Verification",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                    ),
                    
                    const SizedBox(height:40 ,),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Verify Email",
                        style: 
                        TextStyle(
                          color: Color.fromARGB(255, 73, 76, 79),
                          fontSize: 27,
                          fontWeight: FontWeight.w700),),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color.fromARGB(255, 46, 48, 54),
                          child: IconButton(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            onPressed: (()=>forgot()) , icon: const Icon(Icons.arrow_forward)
                          ),
                        ),
                        const SizedBox(height: 40,)
                      ],
                      
                    ),
                    
                  ],
                ),
              ),
            )
          ],
        ),
        ),
    );
  }
}