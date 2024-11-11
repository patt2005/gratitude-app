import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Post {
  final String title;
  final String description;
  final PostIcon icon;
  final DateTime date;
  final String category;
  final Color color;

  Post({
    required this.title,
    required this.description,
    this.icon = PostIcon.smile,
    required this.date,
    required this.category,
    required this.color,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'icon': icon.index,
        'date': date.toIso8601String(),
        'category': category,
        'color': color.value,
      };

  static Post fromJson(Map<String, dynamic> json) => Post(
        title: json['title'],
        description: json['description'],
        icon: PostIcon.values[json['icon']], // Retrieve icon from enum
        date: DateTime.parse(json['date']),
        category: json['category'],
        color: Color(json['color']),
      );
}

final List<String> categories = [
  "Awesome",
  "Happy",
  "Content",
  "Neutral",
  "Anxious",
  "Sad",
  "Terrible",
];

enum PostIcon {
  laugh(FontAwesomeIcons.faceLaughSquint),
  smile(FontAwesomeIcons.faceSmile),
  grin(FontAwesomeIcons.faceGrinTongue),
  meh(FontAwesomeIcons.faceMeh),
  rollingEyes(FontAwesomeIcons.faceRollingEyes),
  sadTear(FontAwesomeIcons.faceSadTear),
  sadCry(FontAwesomeIcons.faceSadCry);

  final IconData icon;
  const PostIcon(this.icon);
}

final List<IconData> icons = [
  FontAwesomeIcons.faceLaughSquint,
  FontAwesomeIcons.faceSmile,
  FontAwesomeIcons.faceGrinTongue,
  FontAwesomeIcons.faceMeh,
  FontAwesomeIcons.faceRollingEyes,
  FontAwesomeIcons.faceSadTear,
  FontAwesomeIcons.faceSadCry,
];

final List<Color> colors = [
  const Color(0xFF4CAF50),
  const Color(0xFF667BC6),
  const Color(0xFF2196F3),
  const Color(0xFF9E9E9E),
  const Color(0xFFFF5722),
  const Color(0xFF673AB7),
  const Color(0xFFF44336),
];
