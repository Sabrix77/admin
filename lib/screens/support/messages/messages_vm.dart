import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/chat.dart';
import 'package:gobid_admin/model/message.dart';
import 'package:gobid_admin/network/remote/db_utils_chat.dart';
import 'package:gobid_admin/screens/support/messages/messages_navigator.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';

class MessagesViewModel extends BaseViewModel<MessagesNavigator> {
  Stream<QuerySnapshot<Message>> getMessages(String userId) {
    return DBUtilsChat.getUserMessages(userId);
  }

  void sendMessage({
    required Message message,
    required Chat chat,
  }) async {
    try {
      await DBUtilsChat.setChat(chat);
      await DBUtilsChat.updateChatContent(
          chatId: chat.id, timeStamp: message.id, lastContent: message.content);
      await DBUtilsChat.setMessage(chatId: chat.id, message: message);
    } catch (e) {
      navigator!.showMessage(AppStrings.somethingWontWrong, AppStrings.ok);
    }
  }
}
