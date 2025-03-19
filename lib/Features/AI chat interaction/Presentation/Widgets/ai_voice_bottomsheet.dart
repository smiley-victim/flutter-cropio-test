import 'package:flutter/material.dart';


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
                  children: [
                    Expanded(
                      child:Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(""),
                        ),
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black,width: 1)
                              ),
                              child: Icon(Icons.mic_none,color: Colors.white,),
                            ),
                             Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.keyboard,),
                            ),
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
