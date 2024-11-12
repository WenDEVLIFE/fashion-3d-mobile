import 'package:flutter/material.dart';
import '../../dummy_data/all_dummy_data.dart';
import 'component/chat_list_app_bar.dart';
import 'component/chat_list_component.dart';
import 'component/empty_chat_list_component.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 85;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const SizedBox(),
        toolbarHeight: appBarHeight,
        flexibleSpace: const ChatListAppBar(height: appBarHeight),
      ),
      body: CustomScrollView(
        slivers: [
          // const SliverAppBar(
          //   expandedHeight: appBarHeight,
          //   systemOverlayStyle:
          //   SystemUiOverlayStyle(statusBarColor: lightningYellowColor),
          //   flexibleSpace: ChatListAppBar(height: appBarHeight),
          // ),
          chatList.isEmpty
              ? const EmptyChatListComponent()
              : ChatListComponent(chatList: chatList),
          const SliverToBoxAdapter(child: SizedBox(height: 65)),
        ],
      ),
    );
  }
}
