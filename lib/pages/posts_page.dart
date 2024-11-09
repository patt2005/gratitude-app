import 'package:gratitude_app/pages/post_page.dart';
import 'package:gratitude_app/services/journal_service.dart';
import 'package:gratitude_app/utilities/utils.dart';
import 'package:gratitude_app/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    final JournalService journalService = Provider.of<JournalService>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Image.asset(
            "assets/images/heart.png",
            width: 50,
            height: 50,
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemCount: journalService.posts.length,
          itemBuilder: (context, index) {
            return PostWidget(
              post: journalService.posts[index],
            );
          },
        ),
      ),
    );
  }
}
