import 'package:flutter/material.dart';
import '../models/mbti_type.dart';

class MbtiGridItem extends StatelessWidget {
  final MbtiType mbtiType;
  final VoidCallback onTap;

  const MbtiGridItem({
    super.key,
    required this.mbtiType,
    required this.onTap,
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
    // 預先計算顏色，避免重複計算
    final typeColor = getMbtiTypeColor(mbtiType.code);

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 添加圖片
              Expanded(
                child: Image.asset(
                  'assets/images/${mbtiType.code}.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // 顯示MBTI名稱，使用對應顏色
              Text(
                mbtiType.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: typeColor,
                ),
              ),
              // 顯示MBTI代碼，使用對應顏色
              Text(
                mbtiType.code,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
