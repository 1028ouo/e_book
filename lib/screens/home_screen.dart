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

  // 為每個MBTI群組定義圖標
  final Map<String, IconData> _groupIcons = {
    '分析型 (NT)': Icons.lightbulb_outline, // 心理/分析相關圖標
    '外交型 (NF)': Icons.handshake_outlined, // 交流/溝通相關圖標
    '守衛型 (SJ)': Icons.shield_outlined, // 保護/守衛相關圖標
    '探索型 (SP)': Icons.explore_outlined, // 探索/冒險相關圖標
  };

  @override
  void initState() {
    super.initState();
    _mbtiTypesFuture = MbtiService().loadMbtiTypes();
  }

  // 判斷MBTI類型屬於哪個組
  String _getGroupName(String code) {
    if (code.contains('NT')) return _mbtiGroups[0]; // NT
    if (code.contains('NF')) return _mbtiGroups[1]; // NF
    if (code.contains('S') && code.contains('J')) return _mbtiGroups[2]; // SJ
    if (code.contains('S') && code.contains('P')) return _mbtiGroups[3]; // SP
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.psychology,
                size: 28, color: Color.fromARGB(255, 39, 39, 39)),
            SizedBox(width: 10),
            Text(
              'MBTI 16種人格',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Color.fromARGB(255, 39, 39, 39),
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 231, 223, 234), // 分析型背景色
                Color.fromARGB(255, 255, 245, 225), // 淺黃色調
              ],
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline,
                color: Color.fromARGB(255, 80, 80, 80)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('MBTI 人格類型介紹應用'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
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
                        child: Row(
                          children: [
                            Icon(
                              _groupIcons[group],
                              size: 24,
                              color: Colors.black87,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              group,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
