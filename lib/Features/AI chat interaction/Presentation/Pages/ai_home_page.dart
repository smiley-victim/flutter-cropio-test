import 'package:flutter/material.dart';
import 'package:myapp/Features/AI%20chat%20interaction/Presentation/Pages/chat_page.dart';
// import 'package:reminder_page/ai_page/ai_voice_bottomsheet.dart';
// import 'package:reminder_page/chat_page/chat_history.dart';
// import 'package:reminder_page/chat_page/chat_page.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'chat_history.dart';

class AIHomePage extends StatefulWidget {
  const AIHomePage({super.key});

  @override
  State<AIHomePage> createState() => _AIHomePageState();
}

class _AIHomePageState extends State<AIHomePage> {

  List question = [
    "Crop Disease Detection",
    "Crop Analysis",
    "Automatic Weeding",
    "Crop Management",
    "Pesticides Management",
  ];

  final TextEditingController _searchController = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnable = false;
  String text = "";

  @override
  void initState() {
    super.initState();
    initSpeech();

  }

  void initSpeech() async{
    _speechEnable  = await _speechToText.initialize();
    setState(() {});
  }

  void _onSpeechResult(result){
    setState(() {
      text = result.recognizedWords;
    });
  }

  void _startListening() async {
    await _speechToText.listen(onResult:_onSpeechResult);
    setState(() {});
  }

  void _stopListening() async{
    await _speechToText.stop();
    setState(() {

    });
  }

  

  void bottomsheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (context){
        return StatefulBuilder(
          builder: (context,setState){
            return SingleChildScrollView(
              child: Container(
                height: 500,
               padding: EdgeInsets.all(25),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/wallpaper5.jpg"),
              fit : BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.agriculture,color: Colors.white,),
                      ),
                      SizedBox(width: 10,),
                  Text("Leafy AI Assistant",style: TextStyle(fontFamily: "Poppins", fontSize: 25,fontWeight: FontWeight.bold),),
                ],
              ),
              Center(
                child: Text("🌾 Empower your agriculture with AI-powered insights for smarter harvests—cultivating success with instant intelligence at your fingertips! 🌦🚀",
                style: TextStyle(fontFamily: "Poppins", fontSize: 19,fontWeight: FontWeight.bold),),
              ),
              Container(
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                  color: Color.fromRGBO(240, 241, 242, 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      child: Container(
                        constraints: BoxConstraints(minHeight: 50, maxHeight: 150),
                        padding: EdgeInsets.all(5),
                        child: Text(_speechToText.isListening
                                  ? text
                                  : _speechEnable 
                                      ? "Tap the microphone to start Listening.."
                                      : "Audio is not available",
                                      style: TextStyle(fontFamily: "Poppins", fontSize: 17,fontWeight: FontWeight.w500),
                                      ),
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: _speechToText.isListening ? _stopListening : _startListening,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _speechToText.isListening ? Colors.white :Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black,width: 1)
                                ),
                                child: _speechToText.isListening ?Icon(Icons.stop,color: Colors.black,) 
                                :Icon(Icons.mic_none,color: Colors.white,),
                              ),
                        ),
                          //    Container(
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          //     width: 50,
                          //     height: 50,
                          //     decoration: BoxDecoration(
                          //       color: Colors.grey.shade200,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Icon(Icons.keyboard,),
                          //   ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Center(
                  child:  Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 174, 230, 186),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:Center(child: Text("X", style: TextStyle(fontFamily: "Poppins", fontSize: 20,fontWeight: FontWeight.bold,),)),
                        ),
                ),
              ),
            ],
          ), 
              ),
            );
          });
      });
  }


  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/wallpaper3.jpg"),
              fit : BoxFit.cover,
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: Icon(Icons.keyboard_arrow_left,size: 30,),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatHistory()));
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.history,size: 30,),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text("Hello, Leafy here\nHow can I help you?",
                style: TextStyle(fontFamily: "Poppins",fontSize: 34,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                // Horizontal Scroll for Questions
            SizedBox(
              height: 40, // Fixed height
              child: Wrap(
                spacing: 8.0, // Space between items horizontally
                runSpacing: 8.0, // Space between items vertically
                children: question.map((text) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        _searchController.text = text;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Text(
                        text,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: screenWidth * 0.70,
                  child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Type a message..",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            //margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.insert_photo_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            bottomsheet(context);
                          },
                          child: Icon(
                            Icons.graphic_eq,
                            size: 25,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                        fillColor: Colors.white,
                      )),
                ),
                    IconButton(
                      onPressed: (){
                        if(_searchController.text.trim().isNotEmpty){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context)=>ChatPage(conversationID: '',
                            initialQuery: _searchController.text.trim()))
                            );
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please Enter text first",
                            style: TextStyle(fontFamily: "Poppins", color: Colors.black, fontSize: 19,fontWeight: FontWeight.w500),
                            ),
                            backgroundColor: Colors.white60,));
                        }
                      }, 
                      icon: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.send,color: Colors.white,),
                      )
                      ),
              ],
            ),
          ],
        ),
        ),
    );
  }
}