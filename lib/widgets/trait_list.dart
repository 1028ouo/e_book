import 'package:flutter/material.dart';

class TraitList extends StatelessWidget {
  final List<String> traits;
  final String title;

  const TraitList({
    super.key,
    required this.traits,
    required this.title,
  });

  // 根據MBTI型別返回顏色
  Color getMbtiTypeColor(String code) {
    // 分析型 (NT): INTJ, INTP, ENTJ, ENTP
    if ((code.contains('NT'))) {
      return const Color.fromARGB(255, 136, 97, 155); // 紫色代表分析型
    }
    // 外交型 (NF): INFJ, INFP, ENFJ, ENFP
    else if (code.contains('NF')) {
      return const Color.fromARGB(255, 51, 164, 116); // 綠色代表外交型
    }
    // 守衛型 (SJ): ISTJ, ISFJ, ESTJ, ESFJ
    else if (code.contains('S') && code.contains('J')) {
      return const Color.fromARGB(255, 66, 152, 180); // 藍色代表守衛型
    }
    // 探索型 (SP): ISTP, ISFP, ESTP, ESFP
    else if (code.contains('S') && code.contains('P')) {
      return const Color.fromARGB(255, 228, 174, 58); // 橙色代表探索型
    } else {
      return Colors.black; // 預設顏色
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = getMbtiTypeColor(title);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: traits.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Card(
                    elevation: 2.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(traits[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
