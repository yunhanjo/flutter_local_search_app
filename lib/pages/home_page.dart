import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/location_view_model.dart';
import '../pages/review_page.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locations = ref.watch(locationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textEditingController,
          onSubmitted: (value) {
            ref.read(locationViewModelProvider.notifier).search(value);
          },
          decoration: InputDecoration(
            hintText: '검색어를 입력해주세요',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
          itemCount: locations.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final location = locations[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewPage(
                      mapX: location.mapx,
                      mapY: location.mapy,
                      title: location.title,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      location.category,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(location.roadAddress),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
