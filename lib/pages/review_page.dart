import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review.dart';
import '../viewmodels/review_view_model.dart';
import 'package:uuid/uuid.dart';

class ReviewPage extends ConsumerWidget {
  final double mapX;
  final double mapY;

  ReviewPage({required this.mapX, required this.mapY, super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('리뷰 목록')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return ListTile(
                  title: Text(review.content),
                  subtitle: Text(review.createdAt.toString()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: '리뷰 작성'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final content = _controller.text.trim();
                    if (content.isEmpty) return;

                    final newReview = Review(
                      id: const Uuid().v4(),
                      content: content,
                      mapX: mapX,
                      mapY: mapY,
                      createdAt: DateTime.now(),
                    );

                    await ref
                        .read(reviewViewModelProvider.notifier)
                        .addReview(newReview);
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
