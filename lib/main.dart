import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ufm/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:ufm/provider/download_provider.dart';
import 'package:ufm/screens/detailpodcast.dart';
import 'package:ufm/screens/routestack.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FileDownloaderProvider(),
          child: MusicApp(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Ufm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MyColors.navy,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: Routes().routes,
        initialRoute: '/stack',
      ),
    );
  }
}

class MyColors {
  static const MaterialColor navy = MaterialColor(
    0xFFFFEB3B,
    // 0xFFF2E307,
    <int, Color>{
      50: Color(0xFFFFFDE7),
      100: Color(0xFFFFF9C4),
      200: Color(0xFFFFF59D),
      300: Color(0xFFFFF176),
      400: Color(0xFFFFEE58),
      500: Color(0xFFFFEB3B),
      600: Color(0xFFFDD835),
      700: Color(0xFFFBC02D),
      800: Color(0xFFF9A825),
      900: Color(0xFFF57F17),
    },
  );
}
