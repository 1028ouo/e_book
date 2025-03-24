import 'package:flutter/material.dart';
import '../models/mbti_type.dart';

class TraitList extends StatelessWidget {
  final List<String> traits;
  final String title;
  final MbtiType mbtiType;

  const TraitList({
    super.key,
    required this.traits,
    required this.title,
    required this.mbtiType,
  });

  // 根據MBTI類型返回對應的淺色調
  Color _getListTileColorByType() {
    String code = mbtiType.code;
    if (code.contains('NT')) {
      // 分析型：淺紫色
      return const Color.fromARGB(255, 250, 250, 250);
    } else if (code.contains('NF')) {
      // 外交型：淺綠色
      return const Color.fromARGB(255, 250, 255, 250);
    } else if (code.contains('S') && code.contains('J')) {
      // 管理型：淺藍色
      return const Color.fromARGB(255, 250, 252, 255);
    } else {
      // 探險型：淺橙色
      return const Color.fromARGB(255, 250, 253, 250);
    }
  }

  Color _getIconColorByType() {
    String code = mbtiType.code;
    if (code.contains('NT')) {
      // 分析型：淺紫色
      return Colors.purple.shade900;
    } else if (code.contains('NF')) {
      // 外交型：淺綠色
      return Colors.green.shade900;
    } else if (code.contains('S') && code.contains('J')) {
      // 管理型：淺藍色
      return Colors.blue.shade900;
    } else {
      // 探險型：淺橙色
      return Colors.yellow.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tileColor = _getListTileColorByType();
    final iconColor = _getIconColorByType();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: traits.length + 1, // 加1是為了標題
      itemBuilder: (ctx, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return Card(
          elevation: 1.0,
          margin: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            tileColor: tileColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            title: Text(traits[index - 1]),
            leading: Icon(
              Icons.check_circle,
              color: iconColor,
            ),
          ),
        );
      },
    );
  }
}
