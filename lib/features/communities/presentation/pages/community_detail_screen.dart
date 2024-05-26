import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/constants/rest_resources.dart';
import 'package:grad_ease/core/theme/color_pallete.dart';
import 'package:grad_ease/features/communities/data/models/community_message_model.dart';
import 'package:grad_ease/features/communities/domain/entity/community_entity.dart';
import 'package:grad_ease/features/communities/domain/entity/community_message_entity.dart';
import 'package:grad_ease/features/communities/presentation/bloc/community_detail/community_detail_bloc.dart';
import 'package:grad_ease/features/communities/presentation/widgets/community_post.dart';
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
    'autoConnect': true,
  });

  final TextEditingController _messageEditingController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  initSocket() {
    socket.connect();
    socket.onConnect((_) {
      socket.emit('joinCommunity', widget.communityEntity.id);
    });
    socket.onDisconnect((_) => print("connection Disconnection"));
  }

  List<CommunityMessageEntity?> messages = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context
        .read<CommunityDetailBloc>()
        .add(FetchAllCommunityMessages(widget.communityEntity.id));
    initSocket();
    socket.on('newMessage', (data) {
      final recivedMessage = CommunityMessageModel.fromJson(data['message']);
      context
          .read<CommunityDetailBloc>()
          .add(AddNewRecivedMessage(recivedMessage.toEntity()));
    });
  }

  @override
  void dispose() {
    socket.dispose();
    _messageEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<CommunityDetailBloc>().state;
    if (_isScrollAtBottom && state.hasMoreData) {
      context.read<CommunityDetailBloc>().add(
            FetchMoreCommunityMessages(
                communityId: widget.communityEntity.id,
                page: (state.messages.length ~/ 10) + 1,
                pageLimit: 10),
          );
    }
  }

  bool get _isScrollAtBottom {
    return (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent);
  }

  void _sendMessage(String message) {
    socket.emit('chatMessage', {
      'communityId': widget.communityEntity.id,
      'message': message,
    });
    context.read<CommunityDetailBloc>().add(SendCommunityMessage(
          message: message,
          communityId: widget.communityEntity.id,
          messages: messages,
        ));
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
                  messages = state.messages;
                  if (messages.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "No messages found",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          return CommunityPost(message: messages[index]!);
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
                        hintText: 'Enter message here',
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
