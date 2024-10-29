import 'package:daily_gratitude_app/pages/navigation_page.dart';
import 'package:daily_gratitude_app/utilities/utils.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final PageController _controller = PageController();

  final List<String> _titles = [
    "Welcome to Gratitude!",
    "Small Steps, Big Impact",
    "Let's Get Grateful!",
  ];
  final List<String> _subtitles = [
    "Cultivate happiness by reflecting on the good things in your life. Take a moment each day to appreciate the positives and embrace a mindset of gratitude.",
    "Start each day with just a few moments of gratitude to shift your perspective. Acknowledge the blessings in your life and set a positive tone for the day ahead.",
    "Write down three things you're grateful for today. We'll be here to guide you every step of the way, helping you to nurture a habit of thankfulness and positivity."
  ];

  OnboardingPage({super.key});

  Widget _buildOnboardingPage(
      String title, String subtitle, String imagePath, BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.15),
            Image.asset(
              imagePath,
              width: 175,
              height: 175,
            ),
            SizedBox(height: screenSize.height * 0.05),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: screenSize.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == _titles.indexOf(title)
                          ? const Color(0xFFDA7297)
                          : Colors.grey,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 14),
                ),
                backgroundColor: WidgetStateProperty.all(
                  const Color(0xFF667BC6),
                ),
              ),
              onPressed: () async {
                if (_titles.indexOf(title) == _titles.length - 1) {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const NavigationPage(),
                    ),
                  );
                } else {
                  await _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _titles.indexOf(title) == _titles.length - 1
                        ? "Get Started"
                        : "Continue",
                    style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.07),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          for (int i = 0; i < _titles.length; i++)
            _buildOnboardingPage(
              _titles[i],
              _subtitles[i],
              "assets/images/image${i + 1}.png",
              context,
            ),
        ],
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}
