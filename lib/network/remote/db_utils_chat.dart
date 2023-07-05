import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gobid_admin/model/chat.dart';
import 'package:gobid_admin/model/message.dart';

class DBUtilsChat {
  static CollectionReference<Chat> getChatCollectionRef() {
    return FirebaseFirestore.instance.collection('chat').withConverter<Chat>(
          fromFirestore: (snapshot, options) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chat, options) => chat.toJson(),
        );
  }

  static Stream<QuerySnapshot<Chat>> getAllChat() {
    var ref = getChatCollectionRef();
    Stream<QuerySnapshot<Chat>> chatSnapshot = ref.orderBy('timeStamp',descending: true).snapshots();
    return chatSnapshot;
  }

  static setChat(Chat chat) async {
    var ref = getChatCollectionRef();
    //chat.id  means client id
    return await ref.doc(chat.id).set(chat);
  }
  static updateChatContent(
      {required String chatId,required String lastContent,required String timeStamp,}) async {
    var ref = getChatCollectionRef();
    //chat.id  means client id

    return await ref.doc(chatId).update({
      'lastContent':lastContent,
      'timeStamp':timeStamp,
    });
  }

  ///for MESSAGES

  static CollectionReference<Message> getMessageCollectionRef(String chatId) {
    return FirebaseFirestore.instance
        .collection('chat')
        .doc(chatId)
        .collection('messages')
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.toJson(),
        );
  }

  static setMessage({required Message message, required String chatId}) async {
    var messagesRef = getMessageCollectionRef(chatId);
    return await messagesRef.doc(message.id).set(message);
  }

  static Stream<QuerySnapshot<Message>> getUserMessages(String userId) {
    try {
      var ref = getMessageCollectionRef(userId);
      Stream<QuerySnapshot<Message>> messagesSnapshot =
          ref.orderBy('timestamp').snapshots();
      return messagesSnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
