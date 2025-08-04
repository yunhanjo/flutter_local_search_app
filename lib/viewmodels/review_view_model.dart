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

  Future<void> loadReviews(double mapX, double mapY) async {
    final reviews = await _repository.fetchReviews(mapX, mapY);
    state = reviews;
  }

  Future<void> addReview(Review review) async {
    await _repository.addReview(review);
    state = [...state, review];
  }
}
