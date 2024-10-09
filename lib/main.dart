import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_motobike_cs_app/firebase_options.dart';
import 'package:flutter_motobike_cs_app/pages/list_chat_page.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/chatting_page.dart';
import 'pages/signin_page.dart';
import 'pages/splash_screen_page.dart';

Future<void> main() async {
  // Tipe firebase plugin jadi harus ditambah si WidgetsFluBin
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFFEFEFF0),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FutureBuilder(
        future: DSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == null) return SplashScreenPage();
          return ListChatPage();
        },
      ),
      routes: {
        '/list-chat': (context) => ListChatPage(),
        '/signin': (context) => SigninPage(),
        '/chatting': (context) {
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          String uid = data['uid'];
          String userName = data['userName'];
          return ChattingPage(
            uid: uid,
            userName: userName,
          );
        },
      },
    );
  }
}
