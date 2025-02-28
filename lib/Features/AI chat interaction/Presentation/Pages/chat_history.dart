import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Data/chatservice.dart';
import 'chat_page.dart';


class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  AIChat obj = AIChat();
  List<Map<String, dynamic>> chats = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchChatHistory();
  }

  Future<void> fetchChatHistory() async {
    try {
      List<Map<String, dynamic>> response = await obj.chatHistory();
      setState(() {
        chats = response;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load chat history. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat History", style: TextStyle(fontFamily: "Poppins", fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen.shade100,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
              ),
              child: Icon(Icons.keyboard_arrow_left_outlined, size: 28, color: Colors.black87),
            ),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : hasError
              ? Center(child: Text("Error loading chats", style: TextStyle(fontFamily: "Poppins",fontSize: 18, color: Colors.red)))
              : chats.isEmpty
                  ? Center(child: Text("No chat history found", style: TextStyle(fontFamily: "Poppins",fontSize: 18, color: Colors.grey)))
                  : Padding(
                      padding: EdgeInsets.all(25),
                      child: ListView.builder(
                        itemCount: chats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.2,
                              motion: const DrawerMotion(),
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(255, 204, 224, 182),
                                          ),
                                          child: const Icon(Icons.delete_outline_outlined, size: 30, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                String conversationID =
                                    chats[index]["conversation_id"];
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    conversationID: conversationID,
                                    initialQuery: '',
                                  ),
                                ));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                margin: const EdgeInsets.only(top: 25),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: ClipOval(
                                        child: Image.asset("assets/images/chat.png", fit: BoxFit.contain),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chats[index]['conversation_name'],
                                            style: TextStyle(fontFamily: "Poppins", fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}
