import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/review_view_model.dart';

class ReviewPage extends ConsumerWidget {
  final double mapX;
  final double mapY;
  final String title;

  const ReviewPage({
    super.key,
    required this.mapX,
    required this.mapY,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewViewModelProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: reviews.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ListTile(
                    title: Text(review.content),
                    subtitle: Text(review.createdAt.toLocal().toString()),
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: '리뷰를 작성해 주세요',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final content = controller.text.trim();
                      if (content.isNotEmpty) {
                        ref
                            .read(reviewViewModelProvider.notifier)
                            .addReview(
                              mapX: mapX,
                              mapY: mapY,
                              content: content,
                            );
                        controller.clear();
                      }
                    },
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
