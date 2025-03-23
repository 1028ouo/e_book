import 'package:flutter/material.dart';
import '../models/mbti_type.dart';
import '../widgets/trait_list.dart';

class MbtiDetailScreen extends StatelessWidget {
  final MbtiType mbtiType;

  const MbtiDetailScreen({
    super.key,
    required this.mbtiType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${mbtiType.code} - ${mbtiType.name}'),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    mbtiType.code,
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    mbtiType.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: '概述'),
                Tab(text: '優勢'),
                Tab(text: '劣勢'),
                Tab(text: '職業'),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // 概述頁籤
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: Padding(
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
                        ),
                      ],
                    ),
                  ),

                  // 優勢頁籤
                  TraitList(traits: mbtiType.strengths, title: '優勢特質'),

                  // 劣勢頁籤
                  TraitList(traits: mbtiType.weaknesses, title: '劣勢特質'),

                  // 職業頁籤
                  TraitList(traits: mbtiType.careerPaths, title: '適合職業'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
