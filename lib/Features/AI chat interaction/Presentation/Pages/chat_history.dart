import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Data/chatservice.dart';
import 'ai_home_page.dart';
import 'chat_page.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  AIChat obj = AIChat();
  List<Map<String, dynamic>> chats = [];
  List<Map<String, dynamic>> archivedChats = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchChatHistory();
    fetchArchivedChats();
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
        SnackBar(
            content: Text("Failed to load chat history. Please try again.")),
      );
    }
  }

  Future<void> fetchArchivedChats() async {
    try {
      List<Map<String, dynamic>> response = await obj.showArchivedChats();
      log(response.toString());
      setState(() {
        archivedChats = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Failed to load chat history. Please try again.")),
      );
    }
  }

  Future<void> _archiveChat(int index) async {
    String response = await obj.archiveChat(chats[index]["conversation_id"]);

    setState(() {
      archivedChats.add(chats[index]); // Move to archived list
      chats.removeAt(index); // Remove from active list
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response)));
  }

  Future<void> _deleteChat(int index) async {
    String response = await obj.deleteChat(chats[index]["conversation_id"]);

    setState(() {
      chats.removeAt(index); // Remove from active list
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(response)));
  }

  /// Show archived chats in bottom sheet
  void showArchivedChats() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow bottom sheet to expand
      backgroundColor: Colors.lightGreen.shade100,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Archived Chats",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: archivedChats.isEmpty
                        ? Center(
                            child: Text(
                              "No Archived Chats",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "Poppins"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: archivedChats.length,
                            itemBuilder: (context, index) {
                              return Container(
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
                                    // Profile Image
                                    Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: ClipOval(
                                        child: Image.asset(
                                            "assets/images/chat.png",
                                            fit: BoxFit.contain),
                                      ),
                                    ),

                                    // Chat Name
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 230,
                                          child: Text(
                                            archivedChats[index]
                                                ['conversation_name'],
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        // Archive & Delete Icons
                                        Column(
                                          children: [
                                            // Unarchive Icon
                                            GestureDetector(
                                              onTap: () async {
                                                String response =
                                                    await obj.unarchiveChat(
                                                        archivedChats[index][
                                                            "conversation_id"]);
                                                setState(() {
                                                  chats.add(
                                                      archivedChats[index]);
                                                  archivedChats.removeAt(index);
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromARGB(
                                                        255, 204, 224, 182),
                                                  ),
                                                  child: const Icon(
                                                      Icons.unarchive_outlined,
                                                      size: 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // Delete Icon
                                            GestureDetector(
                                              onTap: () async {
                                                String response =
                                                    await obj.deleteChat(
                                                        archivedChats[index][
                                                            "conversation_id"]);
                                                setState(() {
                                                  archivedChats.removeAt(index);
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromARGB(
                                                        255, 204, 224, 182),
                                                  ),
                                                  child: const Icon(
                                                      Icons.delete_outline,
                                                      size: 25,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String response = await obj.unarchiveAll();
                      setState(() {
                        chats.addAll(archivedChats);
                        archivedChats.clear();
                      });
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AIHomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.shade300,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    child: Text("Unarchive All",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat History",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.bold)),
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
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
                ],
              ),
              child: Icon(Icons.keyboard_arrow_left_outlined,
                  size: 28, color: Colors.black87),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) async {
              if (value == "archive") {
                String response = await obj.archiveAll();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(response)));
                setState(() {
                  chats.clear();
                });
              } else if (value == "delete") {
                String response = await obj.deleteAll();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(response)));
                setState(() {
                  chats.clear();
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "archive",
                child: Text("Archive All",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
              ),
              PopupMenuItem(
                value: "delete",
                child: Text("Delete All",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
              ),
            ],
          ),
        ],
        toolbarHeight: 100,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Text("Error loading chats",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          color: Colors.red)))
              : Column(
                  children: [
                    Expanded(
                      child: chats.isEmpty
                          ? Center(
                              child: Text("No chat history found",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 18,
                                      color: Colors.grey)))
                          : Padding(
                              padding: EdgeInsets.all(25),
                              child: ListView.builder(
                                itemCount: chats.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      extentRatio: 0.3,
                                      motion: const DrawerMotion(),
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      _archiveChat(index),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromARGB(
                                                            255, 204, 224, 182),
                                                      ),
                                                      child: const Icon(
                                                          Icons
                                                              .archive_outlined,
                                                          size: 30,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      _deleteChat(index),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromARGB(
                                                            255, 204, 224, 182),
                                                      ),
                                                      child: const Icon(
                                                          Icons
                                                              .delete_outline_outlined,
                                                          size: 30,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        String conversationID =
                                            chats[index]["conversation_id"];
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
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
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.16),
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
                                              margin: const EdgeInsets.only(
                                                  right: 15),
                                              width: 50,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: ClipOval(
                                                child: Image.asset(
                                                    "assets/images/chat.png",
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    utf8.decode(chats[index][
                                                            'conversation_name']
                                                        .codeUnits),
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
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
                    ),
                    archivedChats.isNotEmpty
                        ? _buildArchivedChatsButton()
                        : SizedBox(),
                  ],
                ),
    );
  }

  /// Method for Archived Chats Button
  Widget _buildArchivedChatsButton() {
    return GestureDetector(
      onTap: () {
        showArchivedChats();
      },
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.lightGreen.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text("Archived Chats",
            style: TextStyle(color: Colors.grey.shade900, fontSize: 18)),
      ),
    );
  }
}
