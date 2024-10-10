// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motobike_cs_app/source/chat_source.dart';
import 'package:gap/gap.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({super.key});

  @override
  State<ListChatPage> createState() => _ListChatPageState();
}

class _ListChatPageState extends State<ListChatPage> {
  late final Stream<QuerySnapshot<Map<String, dynamic>>> streamChats;

  @override
  void initState() {
    streamChats = FirebaseFirestore.instance
        .collection('CS')
        .snapshots(); // ambil data realtime pake snapshots
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody:
          true, // Pake ini untuk fix jika konten hilang dan bottom navbar ada
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20 + MediaQuery.of(context).padding.top),
            Text(
              "Message",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0XFF070623),
              ),
            ),
            Gap(20),
            Expanded(
              child: buildList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNav(),
    );
  }

  Widget buildBottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 78,
        width: 200,
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0XFF070623),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Row(
          children: [
            buildItemNav(
              label: 'Chats',
              icon: 'assets/ic_chats_on.png',
              iconOn: 'assets/ic_chats_on.png',
              hasDot: true,
              isActive: true,
              onTap: () {},
            ),
            buildItemNav(
              label: 'Logout',
              icon: 'assets/ic_logout.png',
              iconOn: 'assets/ic_logout.png',
              isActive: false,
              onTap: () {
                DSession.removeUser().then(
                  (removed) {
                    // jika gagal remove stay disini pagenya
                    if (!removed) return;

                    // jika berhasil hapus halaman ini dan pindah ke signIn
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemNav({
    required final String label,
    required String icon, // icon off
    required String iconOn,
    required VoidCallback onTap,
    bool isActive = false,
    bool hasDot = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          height: 46,
          child: Column(
            children: [
              Image.asset(
                isActive ? iconOn : icon,
                width: 24.0,
                height: 24.0,
              ),
              Gap(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Color(isActive ? 0XFFFFBC1C : 0XFFFFFFFF),
                    ),
                  ),
                  if (hasDot)
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Color(0XFFFF2056),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return StreamBuilder(
      stream: streamChats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No Chats'),
          );
        }
        final list = snapshot.data!.docs;
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
          itemCount: list.length,
          itemBuilder: (context, index) {
            Map room = list[index].data();
            String uid = room['roomId'];
            String userName = room['name'];
            bool newFromUser = room['newFromUser'];

            return GestureDetector(
              onTap: () {
                ChatSource.openChatRoom(uid, userName).then(
                  (value) {
                    // Setelah selesai Update
                    Navigator.pushNamed(
                      context,
                      '/chatting',
                      arguments: {
                        'uid': uid,
                        'userName': userName,
                      },
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/profile.png",
                      width: 50.0,
                      height: 50.0,
                    ),
                    Gap(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF070623),
                            ),
                          ),
                          Gap(2),
                          Text(
                            room['lastMessage'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: newFromUser
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              fontSize: 14.0,
                              color: newFromUser
                                  ? Color(0XFF070623)
                                  : Color(0XFF838384),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
