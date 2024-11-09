import 'package:gratitude_app/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _launchUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }

  Future<void> _launchEmail(String email) async {
    final emailUrl = Uri(
      scheme: 'mailto',
      path: email,
    ).toString();

    await launchUrl(Uri.parse(emailUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.04),
          Image.asset(
            "assets/images/heart.png",
            width: 70,
            height: 70,
          ),
          SizedBox(height: screenSize.height * 0.03),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Divider(color: Colors.black38),
          ),
          ListTile(
            onTap: () => _launchUrl(
                "https://docs.google.com/document/d/1QZHHNKDJNJqUBTeGoIxs_aclRqd8KLLYuZ5TQehTyRU/edit?usp=sharing"),
            leading: const Icon(
              FontAwesomeIcons.shield,
              color: Color.fromARGB(255, 248, 168, 183),
            ),
            title: const Text("Privacy Policy"),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Divider(color: Colors.black38),
          ),
          ListTile(
            onTap: () => _launchUrl(
                "https://docs.google.com/document/d/1LzActjya_arVffE5kJfPtm26P7ngTRfEmAP-i_JTVZQ/edit?usp=sharing"),
            leading: const Icon(
              FontAwesomeIcons.info,
              color: Color.fromARGB(255, 248, 168, 183),
            ),
            title: const Text("Terms of Use"),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Divider(color: Colors.black38),
          ),
          ListTile(
            onTap: () => _launchEmail("leahreyestr@gmx.com"),
            leading: const Icon(
              FontAwesomeIcons.message,
              color: Color.fromARGB(255, 248, 168, 183),
            ),
            title: const Text("Contact Us"),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Divider(color: Colors.black38),
          ),
          ListTile(
            onTap: () => _launchUrl("https://your-apps-url.com"),
            leading: const Icon(
              FontAwesomeIcons.googlePlay,
              color: Color.fromARGB(255, 248, 168, 183),
            ),
            title: const Text("Our Apps"),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Divider(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
