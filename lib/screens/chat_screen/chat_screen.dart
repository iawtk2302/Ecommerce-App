import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/enums/message_type.dart';
import 'package:ecommerce_app/models/message.dart';
import 'package:ecommerce_app/repositories/chat_repository.dart';
import 'package:ecommerce_app/screens/chat_screen/widgets/message_input.dart';
import 'package:ecommerce_app/screens/chat_screen/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String routeName = '/chat-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userBloc = context.read<UserBloc>();
    final user = userBloc.state as UserLoaded;
    userId = user.user.id;
    context.read<ChatBloc>().add(LoadChatRoom(
        id: userId, imgUrl: user.user.imageUrl, name: user.user.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const CustomLoadingWidget();
          } else if (state is ChatLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: ChatRepository()
                            .getMessages("GXJg9eOUXsNiPjIiwTnvOQvDtK43_admin"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.size > 0) {
                            List<Message> messages = snapshot.data!.docs
                                .map((e) => Message.fromMap(
                                    e.data() as Map<String, dynamic>))
                                .toList();
                            return ListView.builder(
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return MessageItem(message: messages[index]);
                              },
                            );
                          } else {
                            return const Center(
                              child: Text('No message'),
                            );
                          }
                        }),
                  ),
                  MessageInput(
                    chatRoomId: 'GXJg9eOUXsNiPjIiwTnvOQvDtK43_admin',
                    userId: userId,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
