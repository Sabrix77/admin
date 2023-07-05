import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/chat.dart';
import 'package:gobid_admin/model/message.dart';
import 'package:gobid_admin/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import 'message_widget.dart';
import 'messages_navigator.dart';
import 'messages_vm.dart';

class MessagesScreen extends StatefulWidget {
  static const String routeName = 'MessagesScreen';

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends BaseView<MessagesScreen, MessagesViewModel>
    implements MessagesNavigator {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  MessagesViewModel initViewModel() {
    return MessagesViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    Chat newChat = ModalRoute.of(context)!.settings.arguments as Chat;
    if(newChat.lastContent==null)messageController.text='Congratulations sir 🎉,\nYou Are Our Auction Winner\nPlease Confirm and Continue from Winning Products section';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, right: 20, bottom: 30, left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
                // child: Container(),
                child: StreamBuilder<QuerySnapshot<Message>>(
              stream: viewModel.getMessages(newChat.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (snapshot.hasError) {
                  return const Center(child: Text("something went wrong"));
                }
                var messages =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                print('======msg${messages.length}');

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageWidget(messages[index]);
                  },
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 12, bottom: 10, right: 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          hintText: "type a message",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2))),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff528485),
                    ),
                    child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {
                          //TODO Refactor this سباكتي too
                          String id = DateTime.now().toIso8601String();
                          int timestamp = DateTime.now().millisecondsSinceEpoch;
                          Message message = Message(
                            id: id,
                            senderId: authProvider.myUser!.id,
                            content: messageController.text,
                            timestamp: timestamp,
                          );
                          newChat.lastContent=messageController.text;
                          newChat.timeStamp=id;
                          // chat.lastContent = messageController.text;
                          // chat.timeStamp=id;
                          viewModel.sendMessage(message: message, chat: newChat,);
                          messageController.clear();
                        },
                        child: const Icon(Icons.send,
                            size: 26, color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
