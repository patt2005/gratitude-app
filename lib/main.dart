import 'package:gratitude_app/pages/intro_page.dart';
import 'package:gratitude_app/services/journal_service.dart';
import 'package:gratitude_app/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: kBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: kBackgroundColor,
    ),
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => JournalService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      title: "Gratitude",
      theme: ThemeData(fontFamily: "Playwrite"),
      home: const IntroPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
