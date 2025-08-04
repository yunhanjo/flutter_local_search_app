import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review.dart';
import '../repositories/review_repository.dart';

final reviewViewModelProvider =
    StateNotifierProvider<ReviewViewModel, List<Review>>((ref) {
      return ReviewViewModel();
    });

class ReviewViewModel extends StateNotifier<List<Review>> {
  ReviewViewModel() : super([]);

  final _repository = ReviewRepository();

  Future<void> loadReviews({required double mapX, required double mapY}) async {
    final result = await _repository.getReviews(mapX: mapX, mapY: mapY);
    state = result;
  }

  Future<void> addReview({
    required double mapX,
    required double mapY,
    required String content,
  }) async {
    final newReview = await _repository.addReview(
      mapX: mapX,
      mapY: mapY,
      content: content,
    );
    state = [...state, newReview];
  }
}
