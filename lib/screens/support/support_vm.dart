import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/chat.dart';
import 'package:gobid_admin/network/remote/db_utils_chat.dart';

class SupportViewModel extends BaseViewModel {
  Stream<QuerySnapshot<Chat>> getAllChat() {
    return DBUtilsChat.getAllChat();
  }
}
