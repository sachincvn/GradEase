import 'package:flutter/material.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/feeds/data/feed_post_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CommunityDetailScreen extends StatefulWidget {
  final String communityTitle;
  const CommunityDetailScreen({Key? key, required this.communityTitle})
      : super(key: key);

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  final IO.Socket socket = IO.io(RestResources.baseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  final TextEditingController _messageEditingController =
      TextEditingController();

  initSocket() {
    socket.connect();
    socket.onConnect((_) {
      print("Connection established");
      socket.emit('joinCommunity', 'community123');
    });
    socket.onDisconnect((_) => print("connection Disconnection"));
  }

  List<FeedPostModelTemp> _messages = [];
  @override
  void initState() {
    super.initState();
    initSocket();
    socket.on('newMessage', (data) {
      print("newMessage");
      setState(() {
        _messages
            .add(FeedPostModelTemp(message: data['message'], name: "sachin"));
      });
    });
  }

  @override
  void dispose() {
    socket.dispose();
    _messageEditingController.dispose();
    super.dispose();
  }

  void _sendMessage(String message) {
    socket.emit('chatMessage', {
      'communityId': 'community123',
      'message': message,
    });
    _messageEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: ColorPallete.whiteColor),
        centerTitle: true,
        title: Text(
          widget.communityTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _communityPost(context, _messages[index]);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 100,
                      controller: _messageEditingController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Enter message',
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _sendMessage(_messageEditingController.text);
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _communityPost(BuildContext context, FeedPostModelTemp message) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ColorPallete.transparentColor,
                  minRadius: 28,
                  child: Image.network(
                      height: 44,
                      fit: BoxFit.cover,
                      "https://cdn-icons-png.freepik.com/512/7088/7088431.png?filename=teen_7088431.png&fd=1"),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Sachin Chavan",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w400),
                        children: [
                          const TextSpan(text: " - "),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontWeight: FontWeight.w300),
                            text: "10-4-2023 12:00 Am",
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "sachin@gmail.com",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.w200),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 60),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                          text: message.message,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(color: Color.fromARGB(110, 54, 67, 82)),
      ],
    );
  }
}
