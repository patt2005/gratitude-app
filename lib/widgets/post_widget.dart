import 'package:flutter/cupertino.dart';
import 'package:gratitude_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gratitude_app/services/journal_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 7,
              spreadRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with date and category
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date Display
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey.shade200,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.calendar,
                          color: Colors.black54,
                          size: 15,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          DateFormat('d MMM yyyy').format(post.date),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Category Display
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: post.color.withOpacity(0.3),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(
                          post.icon.icon,
                          color: Colors.black87,
                          size: 15,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          post.category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            // Post content
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Title
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Post Description
                  Text(
                    post.description,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      try {
                        final box = context.findRenderObject() as RenderBox?;
                        await Share.share(
                          "${post.title}\n${post.description}",
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size,
                        );
                      } catch (e) {
                        debugPrint("Error while sharing: $e");
                      }
                    },
                    icon: const Icon(CupertinoIcons.share,
                        color: Colors.blueAccent),
                    label: const Text(
                      "Share",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text("Confirm Deletion"),
                          content: const Text(
                              "Are you sure you want to delete this post?"),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancel"),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                final provider = Provider.of<JournalService>(
                                    context,
                                    listen: false);
                                provider.deletePost(post);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
