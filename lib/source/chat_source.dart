import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat.dart';

class ChatSource {
  static Future<void> openChatRoom(String uid, String userName) async {
    // final doc =
    //     await FirebaseFirestore.instance.collection('CS').doc(uid).get();
    // if (doc.exists) {
    await FirebaseFirestore.instance.collection('CS').doc(uid).update({
      'newFromUser': false,
    });

    //   // First time chat room
    //   await FirebaseFirestore.instance.collection('CS').doc(uid).set({
    //     'roomId': uid,
    //     'name': userName,
    //     'lastMessage': 'Wellcome to Motobike',
    //     'newFromUser': false,
    //     'newFromCs': true,
    //   });

    //   await FirebaseFirestore.instance
    //       .collection('CS')
    //       .doc(uid)
    //       .collection('chats')
    //       .add({
    //     'roomId': uid,
    //     'message': 'Wellcome to Motobike',
    //     'receiverId': uid,
    //     'senderId': 'cs',
    //     'bikeDetail': null,
    //     'timestamp': FieldValue.serverTimestamp(),
    //   });
  }

  static Future<void> send(Chat chat, String uid) async {
    await FirebaseFirestore.instance.collection('CS').doc(uid).update({
      'lastMessage': chat.message,
      'newFromUser': false,
      'newFromCs': true,
    });
    await FirebaseFirestore.instance
        .collection('CS')
        .doc(uid)
        .collection('chats')
        .add({
      'roomId': chat.roomId,
      'message': chat.message,
      'receiverId': chat.receiverId,
      'senderId': chat.senderId,
      'bikeDetail': chat.bikeDetail,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
