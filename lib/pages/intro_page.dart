import 'dart:async';
import 'package:gratitude_app/pages/navigation_page.dart';
import 'package:gratitude_app/pages/onboarding_page.dart';
import 'package:gratitude_app/services/journal_service.dart';
import 'package:gratitude_app/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  String loadingText = 'Loading';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
          setState(() {
            if (loadingText.length < 10) {
              loadingText += '.';
            } else {
              loadingText = 'Loading';
            }
          });
        });
        _navigate();
      },
    );
  }

  void _navigate() async {
    final provider = Provider.of<JournalService>(context, listen: false);
    await provider.loadPosts();
    if (await isFirstAppLaunch()) {
      await Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OnboardingPage(),
          ),
        ),
      );
    } else {
      await Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const NavigationPage(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loadingText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
