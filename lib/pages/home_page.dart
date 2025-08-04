import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textEditingController = TextEditingController();

  // 예시 검색 결과
  final List<Map<String, String>> searchResults = [
    {'title': '스타벅스 홍대점', 'category': '카페', 'roadAddress': '서울 마포구 양화로 123'},
    {'title': '파리바게뜨 합정점', 'category': '베이커리', 'roadAddress': '서울 마포구 독막로 25'},
  ];

  void search(String keyword) {
    print('검색어: $keyword');
    // 실제 API 결과로 searchResults를 업데이트하려면 setState 사용
    // setState(() {
    //   searchResults = ...;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          maxLines: 1,
          controller: textEditingController,
          onSubmitted: search,
          decoration: InputDecoration(
            hintText: '검색어를 입력해 주세요',
            border: MaterialStateOutlineInputBorder.resolveWith((states) {
              if (states.contains(WidgetState.focused)) {
                return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                );
              }
              return OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              );
            }),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: searchResults.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = searchResults[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['category'] ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(item['roadAddress'] ?? ''),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
