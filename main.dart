import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  List<String> _messages = [];

  void _sendMessage(String message) async {
    // Replace 'YOUR_CHATGPT_API_ENDPOINT' with the actual ChatGPT API endpoint
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body:
          '{"model":"gpt-3.5-turbo","messages": [{"role": "user", "content": "$message"}]}',
    );

    if (response.statusCode == 200) {
      setState(() {
        _messages.add(message);
        _messages.add(response.body);
        // _messages.add(response.body[4][1][1]);
      });
      _textController.clear();
    } else {
      print('Failed to send message. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT Flutter'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _sendMessage(_textController.text);
                    }
                  },
                  child: Builder(builder: (context) {
                    return const Text('Send');
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _messageController = TextEditingController();
  List<String> _response = []; // Initialize as an empty list

  Future<void> _sendMessage() async {
    const apiKey =
        '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'; // Replace with your ChatGPT API key
    const endpoint =
        'https://api.chatgpt.com/v1/chat'; // Use the correct ChatGPT API endpoint

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Authorization': 'Bearer $apiKey'},
      body: {
        'messages': [_messageController.text]
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Assuming the API response is a list of strings
      final messages = jsonResponse['choices'][0]['message']['content'];

      setState(() {
        // Check if it's a list, then assign; otherwise, use an empty list
        _response = messages is List ? List<String>.from(messages) : [];
      });
    } else {
      // Handle errors
      print('Error in ChatGPT API request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type a message',
                    ),
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: _sendMessage,
                tooltip: 'Send',
                child: const Icon(Icons.send),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Display each string on a new line
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in _response) Text('Response: $item'),
            ],
          ),
        ],
      ),
    );
  }
}
*/