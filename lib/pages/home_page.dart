import 'package:gratitude_app/models/quote.dart';
import 'package:gratitude_app/pages/post_page.dart';
import 'package:gratitude_app/pages/posts_page.dart';
import 'package:gratitude_app/services/journal_service.dart';
import 'package:gratitude_app/utilities/utils.dart';
import 'package:gratitude_app/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> dailyChallenges = [
    "Write about someone who made you smile recently.",
    "What is one thing you're grateful for in your home?",
    "Describe a recent meal you truly enjoyed.",
    "Write about a challenge you're grateful you overcame.",
    "Name one person who has supported you this week.",
    "Describe a simple pleasure you enjoyed today.",
    "What is a piece of advice you're thankful for?",
  ];

  String getDailyChallenge() {
    final today = DateTime.now();
    return dailyChallenges[today.weekday % dailyChallenges.length];
  }

  Widget _buildQuoteContainer(Quote quote, Function refreshQuote) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
            spreadRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: screenSize.width,
      child: Column(
        children: [
          Text(
            '"${quote.text}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            quote.author,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => refreshQuote(),
            child: const Text("Refresh Quote"),
          ),
        ],
      ),
    );
  }

  Widget _buildPostActions(BuildContext context, String postText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            final snackBar = SnackBar(
              content: Text('You can share: "$postText"'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post deleted')),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final JournalService journalService = Provider.of<JournalService>(context);

    void refreshQuote() async {
      await journalService.getQuote();
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PostPage(),
                ),
              );
            },
            child: const Text(
              "Add Post",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 7),
        ],
        backgroundColor: kBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Image.asset(
            "assets/images/heart.png",
            width: 50,
            height: 50,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    formatDate(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.015),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "What are you\ngrateful today?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.04),
              journalService.quote.text.isEmpty
                  ? FutureBuilder(
                      future: journalService.getQuote(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return _buildQuoteContainer(
                              journalService.quote, refreshQuote);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : _buildQuoteContainer(journalService.quote, refreshQuote),
              SizedBox(height: screenSize.height * 0.03),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 7,
                      spreadRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Daily Gratitude Challenge",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      getDailyChallenge(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Consumer<JournalService>(
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Journal",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      if (value.posts.isNotEmpty)
                        TextButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PostsPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                    ],
                  );
                },
              ),
              journalService.posts.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: screenSize.height * 0.01),
                        Image.asset(
                          "assets/images/swing.png",
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        const Text(
                          "No posts",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        const Text(
                          'You still haven\'t shown your gratitude. Tap on "Add Post"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.01),
                      child: Column(
                        children: journalService.posts.map((post) {
                          return Column(
                            children: [
                              PostWidget(post: post),
                              _buildPostActions(context, post.title),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
