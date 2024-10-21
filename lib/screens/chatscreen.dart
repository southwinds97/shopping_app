import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String memberId = '';
  String memberName = '';
  DatabaseReference? _messagesRef;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getString('memberId') ?? '';
      _messagesRef = FirebaseDatabase.instance.ref().child(memberId);
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && _messagesRef != null) {
      String formattedTime = DateFormat('HH:mm').format(DateTime.now());
      _messagesRef!.push().set({
        'id': memberId,
        'message': _controller.text,
        'time': formattedTime,
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅 문의',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messagesRef == null
                ? const Center(child: CircularProgressIndicator())
                : StreamBuilder(
                    stream: _messagesRef!.onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data!.snapshot.value != null) {
                        Map data = snapshot.data!.snapshot.value as Map;
                        List items = [];
                        data.forEach((index, data) =>
                            items.add({"key": index, ...data}));
                        // 시간순으로 정렬
                        items.sort((a, b) => a['time'].compareTo(b['time']));
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            var message = items[index];
                            bool isMe = message['id'] == memberId;
                            return ListTile(
                              title: Align(
                                alignment: isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message['id'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isMe ? mains : Colors.grey[600],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        color: isMe ? mains : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(message['message'],
                                          style: TextStyle(
                                            color: isMe
                                                ? Colors.white
                                                : Colors.black,
                                          )),
                                    ),
                                    Text(
                                      message['time'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return const Center(child: Text('No messages'));
                      }
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: '문의 내용을 입력해주세요',
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: mains,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
