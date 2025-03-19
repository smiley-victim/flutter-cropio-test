import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

abstract class Chatservice {
  // Updated to return list
  Future<List<Map<String,dynamic>>> chatHistory();
  Future<Map<String,dynamic>> loadChats(String conversationID);
  Future<Map<String,dynamic>> continueChat(String conversationID,String query);
  Future<Map<String,dynamic>> newChat(String query);
  Future<String> archiveChat(String conversationID);
  Future<String> deleteChat(String conversationID);
  Future<String> unarchiveChat(String conversationID);
  Future<String> archiveAll();
  Future<String> unarchiveAll();
  Future<String> deleteAll();
  Future<List<Map<String,dynamic>>> showArchivedChats();
}

class AIChat implements Chatservice {
  final String baseUrl = 'https://beta-api.cropio.in/';
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyNDU2NTE4LCJpYXQiOjE3Mzk4NjQ1MTgsImp0aSI6IjJlMDA4MDc5YjUyNTQ1OWI5ZjE0YmIzYWM0YzA4OGIwIiwidXNlcl9pZCI6IjM2NzgzZTQ0LWNhMmEtNDVjNi1iMmNhLTRjZDEwYTUyNGY3OSJ9.xJTR3rVBsdNWVFOv24TN_6_UOMOhVg_NDKKPWs_A9AE';

  @override
  Future<List<Map<String,dynamic>>> chatHistory()async{
    try {
      final url = Uri.parse('${baseUrl}conversations/'); // Construct URL
      final response = await http.get(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call

    log("${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        List<Map<String,dynamic>> conversations = List<Map<String, dynamic>>.from(data['conversations']); 
        log(conversations.toString());

        /// Return processed data
        return conversations; 
      } else {
        throw Exception("Failed to load chat history: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching chat history: $e");
      return []; // Return empty list in case of failure
    }
  }

  /*
  Response :
  {
    "conversations": [
        {
            "conversation_id": "b392cf86-5385-4558-afa8-3a3859e647a8",
            "conversation_name": "👋 Hello There, Let's Chat\n"
        },
        {
            "conversation_id": "231e5a9b-1456-4298-a3f3-aa61204088b5",
            "conversation_name": "👋 Hello There: A Friendly Chat\n"
        },
        {
            "conversation_id": "c8142290-4a0b-474d-8c5d-b44ce1205171",
            "conversation_name": "👋 Hello There, Let's Chat\n"
        },
        {
            "conversation_id": "204f7cdc-da81-4162-95c2-01ba3f438a6b",
            "conversation_name": "👋 Hello There, Let's Chat\n"
        },
        {
            "conversation_id": "b9091857-e1a1-4b0e-8f7a-99d3554bf561",
            "conversation_name": "👋 Hello There, Friend!\n"
        },
        {
            "conversation_id": "14ea91d5-8964-474c-867b-bd3d81ff0064",
            "conversation_name": "👋 Hello, Let's Chat Today\n"
        }
    ]
  } 
*/



  @override
  Future<Map<String,dynamic>> loadChats(String conversationID) async{
    try {
      final url = Uri.parse('${baseUrl}chat/$conversationID/'); // Construct URL
      final response = await http.get(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call
    log("${response.statusCode}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        //Map<String,dynamic> chatDetails = Map<String, dynamic>.from(data); 
        log(data.toString());

        /// Return processed data
        return data; 
      } else {
        throw Exception("Failed to load chat history: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching chat history: $e");
      return {}; // Return empty list in case of failure
    }

  }

   /*
  Response :
  {
    "conversation_id": "b392cf86-5385-4558-afa8-3a3859e647a8",
    "messages": [
        {
            "role": "user",
            "text": "hii",
            "timestamp": "2025-02-19T13:52:45.460976"
        },
        {
            "role": "model",
            "text": "Hello there! How can Nutaan help you today?\n",
            "timestamp": "2025-02-19T13:52:48.016110"
        }
    ]
}
 */

  @override
  Future<Map<String,dynamic>> continueChat(String conversationID,String query)async{
    try {
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}chat/$conversationID/'));

    // Adding fields as form-data
    request.headers['Authorization'] = "Bearer $token"; //  Add Authorization Header
    request.fields['query'] = query;

     // Sending the request
    var streamedResponse = await request.send();

    // Convert streamedResponse to a regular Response
    var response = await http.Response.fromStream(streamedResponse);

    log("${response.statusCode}");

     if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON

        log(data.toString());

        /// Return processed data
        return data; 
      } else {
        throw Exception("Failed to load chat history: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching chat history: $e");
      return {}; // Return empty list in case of failure
    }
  }

   /*
  Response :
  {
    "user_input": "eeuu",
    "file_content": null,
    "model_response": "I'm sorry, I don't understand what \"eeuu\" means. Could you please rephrase your query?\n",
    "search_data": null,
    "conversation_id": "b392cf86-5385-4558-afa8-3a3859e647a8",
    "session_id": "36783e44-ca2a-45c6-b2ca-4cd10a524f79"
}
 */

  @override
  Future<Map<String,dynamic>> newChat(String query)async{
    try {
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}chat/'));

    // Adding fields as form-data
    request.headers['Authorization'] = "Bearer $token"; // Add Authorization Header
    request.fields['query'] = query;

     // Sending the request
    var streamedResponse = await request.send();

    // Convert streamedResponse to a regular Response
    var response = await http.Response.fromStream(streamedResponse);

    log("${response.statusCode}");

     if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON

        log(data.toString());

        /// Return processed data
        return data; 
      } else {
        throw Exception("Failed to load chat history: ${response.body}");
      }
    } catch (e) {
      log("Error fetching chat history: $e");
      return {}; // Return empty list in case of failure
    }
  }

   /*
  Response :
  {
    "message": "New conversation started.",
    "conversation_id": "e81e2972-e151-4621-9b36-1374b9bfc69c",
    "unique_id": "36783e44-ca2a-45c6-b2ca-4cd10a524f79",
    "url": "/chat/e81e2972-e151-4621-9b36-1374b9bfc69c/",
    "conversation_name": "👋 Hello There, Let's Chat\n",
    "model_response": "Hello there! How can I help you today?\n",
    "search_data": null
}
 */

  @override
  Future<String> archiveChat(String conversationID) async{
    try {
      final url = Uri.parse('${baseUrl}archive/$conversationID/'); // Construct URL
      final response = await http.post(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call
    log("${response.statusCode}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        //Map<String,dynamic> chatDetails = Map<String, dynamic>.from(data); 
        log(data.toString());

        /// Return processed data
        return data['message']; 
      } else {
        throw Exception("Failed to archive chat: ${response.statusCode}");
      }
    } catch (e) {
      log("Error to archive chat : $e");
      return ""; // Return empty list in case of failure
    }

  }

  /*
  Response :
  {
    "message": "Conversation archived successfully."
}
 */

 @override
  Future<String> deleteChat(String conversationID) async{
    try {
      final url = Uri.parse('${baseUrl}delete/$conversationID/'); // Construct URL
      final response = await http.delete(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call
    log("${response.statusCode}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        //Map<String,dynamic> chatDetails = Map<String, dynamic>.from(data); 
        log(data.toString());

        /// Return processed data
        return data['message']; 
      } else {
        throw Exception("Failed to delete chat: ${response.statusCode}");
      }
    } catch (e) {
      log("Error to delete chat : $e");
      return ""; 
    }

  }

  /*
  Response :
  {
    "message": "Conversation deleted successfully."
}
 */ 

  @override
  Future<String> unarchiveChat(String conversationID) async{
    try {
      final url = Uri.parse('${baseUrl}unarchive/$conversationID/'); // Construct URL
      final response = await http.post(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call
    log("${response.statusCode}");


    if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        log(data.toString());

        /// Return processed data
        return data['message']; 
      } else {
        throw Exception("Failed to unarchive chat: ${response.statusCode}");
      }
    } catch (e) {
      log("Error to unarchive chat : $e");
      return ""; 
    }

  }

  /*
  Response :
  {
    "message": "Conversation unarchived successfully."
} 
 */

  @override
  Future<String> archiveAll() async{
    try {
      final url = Uri.parse('${baseUrl}archive/'); // Construct URL
      final response = await http.post(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call
    log("${response.statusCode}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        log(data.toString());

        /// Return processed data
        return data['message']; 
      } else {
        throw Exception("Failed to archive chat: ${response.statusCode}");
      }
    } catch (e) {
      log("Error to archive chat : $e");
      return "";
    }

  }

  /*
  Response :
  {
    "message": "All conversations archived successfully."
}
 */

  @override
  Future<String> unarchiveAll() async{
    try {
      final url = Uri.parse('${baseUrl}unarchive-all/'); // Construct URL
      final response = await http.post(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call
    log("${response.statusCode}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        log(data.toString());

        /// Return processed data
        return data['message']; 
      } else {
        throw Exception("Failed to archive chat: ${response.statusCode}");
      }
    } catch (e) {
      log("Error to archive chat : $e");
      return "";
    }

  }

  /*
  Response :
  {
    "message": "All conversations archived successfully."
}
 */

  @override
  Future<String> deleteAll() async{
    try {
      final url = Uri.parse('${baseUrl}delete-all/'); // Construct URL
      final response = await http.delete(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call
    log("${response.statusCode}");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        log(data.toString());

        /// Return processed data
        return data['message']; 
      } else {
        throw Exception("Failed to archive chat: ${response.statusCode}");
      }
    } catch (e) {
      log("Error to archive chat : $e");
      return "";
    }

  }

  /*
  Response :
  {
    "message": "All conversations deleted successfully."
}
 */

@override
  Future<List<Map<String,dynamic>>> showArchivedChats()async{
    try {
      final url = Uri.parse('${baseUrl}archived/'); // Construct URL
      final response = await http.get(url,
      headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
      ); /// API Call

    log("${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body); // Parse JSON
        /// Extract conversations
        List<Map<String,dynamic>> conversations = List<Map<String, dynamic>>.from(data["archived_conversations"]); 
        log(conversations.toString());

        /// Return processed data
        return conversations; 
      } else {
        throw Exception("Failed to load chat history: ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching chat history: $e");
      return []; // Return empty list in case of failure
    }
  }

}
