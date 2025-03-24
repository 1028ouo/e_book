import 'package:flutter/material.dart';
import '../models/mbti_type.dart';
import '../widgets/trait_list.dart';

class MbtiDetailScreen extends StatelessWidget {
  final MbtiType mbtiType;

  const MbtiDetailScreen({
    super.key,
    required this.mbtiType,
  });

  // 根據MBTI類型返回對應的顏色
  Color _getAppBarColorByType() {
    String code = mbtiType.code;
    if (code.contains('NT')) {
      // 分析型：INTJ, INTP, ENTJ, ENTP
      return const Color.fromARGB(255, 136, 97, 155);
    } else if (code.contains('NF')) {
      // 外交型：INFJ, INFP, ENFJ, ENFP
      return const Color.fromARGB(255, 51, 164, 116);
    } else if (code.contains('S') && code.contains('J')) {
      // 管理型：ISTJ, ISFJ, ESTJ, ESFJ
      return const Color.fromARGB(255, 66, 152, 180);
    } else {
      // 探險型：ISTP, ISFP, ESTP, ESFP
      return const Color.fromARGB(255, 228, 174, 58);
    }
  }

  // 獲取較淡的背景顏色
  Color _getLightBackgroundColor() {
    String code = mbtiType.code;
    if (code.contains('NT')) {
      // 分析型：淡紫色
      return const Color.fromARGB(255, 236, 226, 241);
    } else if (code.contains('NF')) {
      // 外交型：淡綠色
      return const Color.fromARGB(255, 233, 253, 243);
    } else if (code.contains('S') && code.contains('J')) {
      // 管理型：淡藍色
      return const Color.fromARGB(255, 228, 244, 249);
    } else {
      // 探險型：淡橙色
      return const Color.fromARGB(255, 252, 243, 226);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lightBgColor = _getLightBackgroundColor();

    return Scaffold(
      appBar: AppBar(
        title: Text('${mbtiType.code} - ${mbtiType.name}'),
        backgroundColor: _getAppBarColorByType(),
        foregroundColor: Colors.white, // 確保文字在彩色背景上清晰可見
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Image.asset('assets/images/cover/${mbtiType.code}_cover.png'),
            Container(
              color: Colors.white,
              child: TabBar(
                tabs: const [
                  Tab(text: '概述'),
                  Tab(text: '優勢'),
                  Tab(text: '劣勢'),
                  Tab(text: '職業'),
                ],
                labelColor: const Color.fromARGB(255, 0, 0, 0),
                unselectedLabelColor: Colors.grey,
                indicatorColor: _getAppBarColorByType(), // 添加指示器顏色與AppBar匹配
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // 概述頁籤
                  Container(
                    color: lightBgColor,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '性格描述',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(mbtiType.description),
                                const SizedBox(height: 16.0),
                                const Text(
                                  '最佳匹配',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(mbtiType.compatibility),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 優勢頁籤
                  Container(
                    color: lightBgColor,
                    child: TraitList(traits: mbtiType.strengths, title: '優勢特質'),
                  ),

                  // 劣勢頁籤
                  Container(
                    color: lightBgColor,
                    child:
                        TraitList(traits: mbtiType.weaknesses, title: '劣勢特質'),
                  ),

                  // 職業頁籤
                  Container(
                    color: lightBgColor,
                    child:
                        TraitList(traits: mbtiType.careerPaths, title: '適合職業'),
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
