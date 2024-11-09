import 'package:gratitude_app/models/post.dart';
import 'package:gratitude_app/services/journal_service.dart';
import 'package:gratitude_app/utilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  List<bool> _selectedCategoryList = [];

  @override
  void initState() {
    super.initState();
    _selectedCategoryList = List.generate(7, (index) => false);
  }

  Future<void> _addPost(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategoryList.contains(true)) {
        final int selectedIndex = _selectedCategoryList.indexOf(true);
        await Provider.of<JournalService>(context, listen: false).addPost(
          Post(
            title: _titleController.text,
            description: _subtitleController.text,
            icon: PostIcon.values[selectedIndex],
            date: DateTime.now(),
            category: categories[selectedIndex],
            color: colors[selectedIndex],
          ),
        );
        _titleController.clear();
        _subtitleController.clear();
        await showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text("Success"),
              content: const Text("The post was successfully added."),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        await showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text("Mood Selection"),
              content: const Text("Please select your mood."),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
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
              await _addPost(context);
            },
            child: const Text(
              "Post",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 7),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.01),
                Image.asset(
                  "assets/images/grateful.png",
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: screenSize.height * 0.01),
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
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title.';
                    }
                    return null;
                  },
                  controller: _titleController,
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "What a wonderful day...",
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < icons.length; i++)
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: _selectedCategoryList[i]
                                ? Border.all(color: colors[i], width: 2)
                                : Border.all(color: Colors.black54),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.all(12),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              backgroundColor: const WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              elevation: const WidgetStatePropertyAll(0),
                            ),
                            onPressed: () {
                              setState(() {
                                for (int j = 0;
                                    j < _selectedCategoryList.length;
                                    j++) {
                                  _selectedCategoryList[j] = false;
                                }
                                _selectedCategoryList[i] = true;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  icons[i],
                                  color: colors[i],
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  categories[i],
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  controller: _subtitleController,
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Today I feel grateful for...",
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  maxLines: null,
                  minLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
