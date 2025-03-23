import 'package:flutter/material.dart';
import '../models/mbti_type.dart';
import '../services/mbti_service.dart';
import '../widgets/mbti_grid_item.dart';
import 'mbti_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<MbtiType>> _mbtiTypesFuture;

  // MBTI 類型分組標題
  final List<String> _mbtiGroups = [
    '分析型 (NT)',
    '外交型 (NF)',
    '守衛型 (SJ)',
    '探索型 (SP)',
  ];

  // 為每個MBTI群組定義背景顏色
  final Map<String, Color> _groupColors = {
    '分析型 (NT)': const Color.fromARGB(255, 231, 223, 234),
    '外交型 (NF)': const Color.fromARGB(255, 214, 236, 226),
    '守衛型 (SJ)': const Color.fromARGB(255, 217, 234, 240),
    '探索型 (SP)': const Color.fromARGB(255, 249, 238, 215),
  };

  @override
  void initState() {
    super.initState();
    _mbtiTypesFuture = MbtiService().loadMbtiTypes();
  }

  // 判斷MBTI類型屬於哪個組
  String _getGroupName(String code) {
    if (code.contains('N') && code.contains('T')) return _mbtiGroups[0]; // NT
    if (code.contains('N') && code.contains('F')) return _mbtiGroups[1]; // NF
    if (code.contains('S') && code.contains('J')) return _mbtiGroups[2]; // SJ
    if (code.contains('S') && code.contains('P')) return _mbtiGroups[3]; // SP
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MBTI 16種人格'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<MbtiType>>(
          future: _mbtiTypesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('發生錯誤: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('沒有MBTI人格資料'));
            }

            // 對MBTI類型進行分組
            final mbtiTypes = snapshot.data!;
            final Map<String, List<MbtiType>> groupedTypes = {};

            for (var group in _mbtiGroups) {
              groupedTypes[group] = [];
            }

            for (var type in mbtiTypes) {
              final group = _getGroupName(type.code);
              groupedTypes[group]?.add(type);
            }

            // 建立分組顯示的列表
            return ListView.builder(
              itemCount: _mbtiGroups.length,
              itemBuilder: (context, index) {
                final group = _mbtiGroups[index];
                final types = groupedTypes[group] ?? [];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _groupColors[group],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 組標題
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: Text(
                          group,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // 網格顯示該組的MBTI類型
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 保持每行 4 個項目
                          childAspectRatio: 0.6, // 降低比例以使項目更高
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: types.length,
                        itemBuilder: (context, index) {
                          return MbtiGridItem(
                            mbtiType: types[index],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MbtiDetailScreen(mbtiType: types[index]),
                              ),
                            ),
                          );
                        },
                      ),
                      // 在網格與容器底部之間添加間距
                      const SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
