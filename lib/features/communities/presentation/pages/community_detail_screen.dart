import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_detail/community_detail_bloc.dart';
import 'package:grad_ease/features/communities/presentation/widgets/community_post.dart';
import 'package:grad_ease/features/feeds/data/feed_post_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CommunityDetailScreen extends StatefulWidget {
  final CommunityEntity communityEntity;
  const CommunityDetailScreen({Key? key, required this.communityEntity})
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
      socket.emit('joinCommunity', 'community123');
    });
    socket.onDisconnect((_) => print("connection Disconnection"));
  }

  List<FeedPostModelTemp> _messages = [];

  @override
  void initState() {
    super.initState();
    context
        .read<CommunityDetailBloc>()
        .add(FetchAllCommunityMessages(widget.communityEntity.id));
    initSocket();
    socket.on('newMessage', (data) {
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
      'communityId': widget.communityEntity.id,
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
          widget.communityEntity.name,
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
            BlocConsumer<CommunityDetailBloc, CommunityDetailState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.communityDetailStateStatus ==
                    CommunityDetailStateStatus.loading) {
                  return const Expanded(
                      child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ));
                } else if (state.communityDetailStateStatus ==
                    CommunityDetailStateStatus.success) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          return CommunityPost(message: state.messages[index]!);
                        }),
                  );
                } else {
                  return const Expanded(child: SizedBox());
                }
              },
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
}
